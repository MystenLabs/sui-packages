module 0x12e75436661d01db94d955d20d1c5fb33c350a010c8f0fa2563d320be7c9142e::usabitch {
    struct USABITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: USABITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USABITCH>(arg0, 6, b"USABITCH", b"AmericanDogWifHat", b"MERICA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7207_00fcfdc476.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USABITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USABITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

