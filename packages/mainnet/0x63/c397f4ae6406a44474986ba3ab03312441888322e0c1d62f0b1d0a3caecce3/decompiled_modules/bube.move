module 0x63c397f4ae6406a44474986ba3ab03312441888322e0c1d62f0b1d0a3caecce3::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"BUBE", b"Bubbles", b"*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000562867_487f9820d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

