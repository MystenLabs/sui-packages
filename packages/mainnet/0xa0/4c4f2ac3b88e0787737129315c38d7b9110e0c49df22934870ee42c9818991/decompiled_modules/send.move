module 0xa04c4f2ac3b88e0787737129315c38d7b9110e0c49df22934870ee42c9818991::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SEND>,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 0, b"SEND", b"Suilend", b"Suilend's native token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/oCqlM51.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEND>(&mut v2, 9314, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEND>>(v1);
        let v3 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<TreasuryAccess>(v3);
    }

    // decompiled from Move bytecode v6
}

