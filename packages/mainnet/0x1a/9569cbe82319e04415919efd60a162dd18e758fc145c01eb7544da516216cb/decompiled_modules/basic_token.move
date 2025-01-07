module 0x1a9569cbe82319e04415919efd60a162dd18e758fc145c01eb7544da516216cb::basic_token {
    struct BASIC_TOKEN has drop {
        dummy_field: bool,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<BASIC_TOKEN>,
    }

    public entry fun burn(arg0: &mut MinterCap, arg1: 0x2::coin::Coin<BASIC_TOKEN>) {
        0x2::coin::burn<BASIC_TOKEN>(&mut arg0.treasury_cap, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BASIC_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASIC_TOKEN>>(0x2::coin::mint<BASIC_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BASIC_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASIC_TOKEN>(arg0, 8, b"BTKN", b"Basic Token", b"Description of the Basic Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASIC_TOKEN>>(v1);
        let v2 = MinterCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::transfer<MinterCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_initial(arg0: &mut MinterCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASIC_TOKEN>>(0x2::coin::mint<BASIC_TOKEN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

