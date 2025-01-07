module 0x30e8439eca382ef05516679fab47b89f40d587094b153471242f8006872199e1::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"Bube", b"Bubbles", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000209390_054c91a102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

