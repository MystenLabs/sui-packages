module 0xe2f487aaf7d464a44155b2e57c2b337ebcf5f387b5839a36dde15688935a8809::clawcat {
    struct CLAWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWCAT>(arg0, 6, b"Clawcat", b"Claw cat", b"claw cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pawnzi111_4b1edcb7b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

