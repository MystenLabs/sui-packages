module 0xc83dc6c2ca0857e57258f5e83443c6ffebdace53dd5589f08f7affe000ce7e70::darktimes {
    struct DARKTIMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKTIMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKTIMES>(arg0, 9, b"DARKTIMES", b"TIMES", b"playdarktimes.com token.  https://x.com/playDARKTIMES.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DARKTIMES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKTIMES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKTIMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

