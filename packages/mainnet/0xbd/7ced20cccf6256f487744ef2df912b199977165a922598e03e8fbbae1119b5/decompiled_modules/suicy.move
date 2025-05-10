module 0xbd7ced20cccf6256f487744ef2df912b199977165a922598e03e8fbbae1119b5::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 6, b"SUICY", b"Suicy the Seal CTO", b"Meet Suicy the Seal CTO, the coolest mascot on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/84njwBJ9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

