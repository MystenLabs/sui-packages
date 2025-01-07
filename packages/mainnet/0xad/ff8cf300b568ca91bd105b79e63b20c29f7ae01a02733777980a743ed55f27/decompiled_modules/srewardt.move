module 0xadff8cf300b568ca91bd105b79e63b20c29f7ae01a02733777980a743ed55f27::srewardt {
    struct SREWARDT has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SREWARDT>,
    }

    fun init(arg0: SREWARDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREWARDT>(arg0, 9, b"SUI", b"Sui", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wixstatic.com/media/33e670_880ba1b76d8242c2b624618ac82c9bc6~mv2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SREWARDT>>(v1);
        let v2 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryAccess>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryAccess, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SREWARDT>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

