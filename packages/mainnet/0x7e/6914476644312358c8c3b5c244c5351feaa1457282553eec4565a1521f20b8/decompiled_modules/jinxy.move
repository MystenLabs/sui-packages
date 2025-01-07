module 0x7e6914476644312358c8c3b5c244c5351feaa1457282553eec4565a1521f20b8::jinxy {
    struct JINXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINXY>(arg0, 6, b"JINXY", b"Jinxy PNUT's sister", b"Lets make this a community driven token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731497679387.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINXY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINXY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

