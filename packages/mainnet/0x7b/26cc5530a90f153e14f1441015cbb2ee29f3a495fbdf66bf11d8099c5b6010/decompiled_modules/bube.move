module 0x7b26cc5530a90f153e14f1441015cbb2ee29f3a495fbdf66bf11d8099c5b6010::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"BUBE", b"Bubbles", b"*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000562867_7893218afd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

