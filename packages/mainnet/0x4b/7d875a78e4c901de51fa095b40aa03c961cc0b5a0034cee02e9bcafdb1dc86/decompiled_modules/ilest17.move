module 0x4b7d875a78e4c901de51fa095b40aa03c961cc0b5a0034cee02e9bcafdb1dc86::ilest17 {
    struct ILEST17 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILEST17, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILEST17>(arg0, 6, b"Ilest17", b"il est 17", b"le monde c'est quoi frero ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17_8c1b237b9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILEST17>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILEST17>>(v1);
    }

    // decompiled from Move bytecode v6
}

