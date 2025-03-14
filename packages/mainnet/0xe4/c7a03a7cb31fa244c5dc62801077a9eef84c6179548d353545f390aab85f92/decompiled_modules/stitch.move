module 0xe4c7a03a7cb31fa244c5dc62801077a9eef84c6179548d353545f390aab85f92::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 9, b"STITCH", b"Stitch", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/kSJl0KzYezv7Ja36-Y4ou8n3ksxX-t-aAaXUkHqA5II")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STITCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STITCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

