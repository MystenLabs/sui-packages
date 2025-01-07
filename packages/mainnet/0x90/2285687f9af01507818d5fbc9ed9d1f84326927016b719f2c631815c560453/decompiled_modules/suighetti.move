module 0x902285687f9af01507818d5fbc9ed9d1f84326927016b719f2c631815c560453::suighetti {
    struct SUIGHETTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGHETTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGHETTI>(arg0, 1, b"SUIGHETTI", b"Suighetti", b"SG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGHETTI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGHETTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGHETTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

