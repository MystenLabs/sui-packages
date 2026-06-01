module 0x17abfa6360e9e295d85043834d26d0c83408fc356a3894bb1c7a17ecdb353e0a::egldx {
    struct EGLDX has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SaleConfig has store, key {
        id: 0x2::object::UID,
        rate: u64,
        admin_wallet: address,
    }

    public entry fun buy_token(arg0: &SaleConfig, arg1: &mut 0x2::coin::TreasuryCap<EGLDX>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin_wallet);
        0x2::coin::mint_and_transfer<EGLDX>(arg1, 0x2::coin::value<0x2::sui::SUI>(&arg2) * arg0.rate, 0x2::tx_context::sender(arg3), arg3);
    }

    public entry fun change_admin_wallet(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_wallet = arg2;
    }

    fun init(arg0: EGLDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGLDX>(arg0, 9, b"EGLDX", b"MultiversX EGLD", b"MultiversX EGLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/JhhdZBdS/EGLD.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = SaleConfig{
            id           : 0x2::object::new(arg1),
            rate         : 100,
            admin_wallet : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGLDX>>(v1);
        0x2::transfer::public_share_object<SaleConfig>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGLDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

