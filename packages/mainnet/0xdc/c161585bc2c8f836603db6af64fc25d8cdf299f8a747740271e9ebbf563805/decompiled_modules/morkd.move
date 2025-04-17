module 0xdcc161585bc2c8f836603db6af64fc25d8cdf299f8a747740271e9ebbf563805::morkd {
    struct MORKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORKD>(arg0, 9, b"MORKD", b"MECOW", b"guagua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/01e16f0f925d36a16fe4cdcf447dd366blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORKD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORKD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

