module 0x9614657c9d7e8799be4f49781ef1a9247b83ee178976df6c92d29b6026b9dadf::mliq {
    struct MLIQ has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        authority: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority,
        treasury_cap: 0x2::coin::TreasuryCap<MLIQ>,
        balance: 0x2::balance::Balance<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>,
        version: u64,
    }

    public fun burn(arg0: &mut Registry, arg1: 0x2::coin::Coin<MLIQ>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ> {
        version_check(arg0);
        0x2::coin::from_balance<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>(0x2::balance::split<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>(&mut arg0.balance, 0x2::coin::burn<MLIQ>(&mut arg0.treasury_cap, arg1) * 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(6 + 6 - 6)), arg2)
    }

    public fun mint(arg0: &mut Registry, arg1: vector<0x2::coin::Coin<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MLIQ> {
        version_check(arg0);
        0x2::balance::join<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>(&mut arg0.balance, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::extract_balance<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>(arg1, arg2 * 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(6 + 6 - 6), arg3));
        0x2::coin::mint<MLIQ>(&mut arg0.treasury_cap, arg2, arg3)
    }

    entry fun update_icon_url(arg0: &Registry, arg1: &mut 0x2::coin::CoinMetadata<MLIQ>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg2);
        0x2::coin::update_icon_url<MLIQ>(&arg0.treasury_cap, arg1, 0x1::ascii::string(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/MLIQ.svg"));
    }

    entry fun add_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::add_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    entry fun burn_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<MLIQ>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = burn(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MLIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLIQ>(arg0, (6 as u8), b"MLIQ", b"Typus MLIQ", b"MLIQ on Sui maintained by Typus Lab", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            authority    : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::new(0x1::vector::singleton<address>(0x2::tx_context::sender(arg1)), arg1),
            treasury_cap : v0,
            balance      : 0x2::balance::zero<0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::LIQ>(),
            version      : 0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLIQ>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    entry fun remove_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::remove_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    entry fun upgrade_registry(arg0: &mut Registry) {
        version_check(arg0);
        arg0.version = 0;
    }

    fun version_check(arg0: &Registry) {
        assert!(0 >= arg0.version, 0);
    }

    // decompiled from Move bytecode v6
}

