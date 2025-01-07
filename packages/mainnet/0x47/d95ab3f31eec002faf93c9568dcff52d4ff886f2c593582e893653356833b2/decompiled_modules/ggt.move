module 0x47d95ab3f31eec002faf93c9568dcff52d4ff886f2c593582e893653356833b2::ggt {
    struct GGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGT>(arg0, 6, b"GGT", b"giggity", b"Giggity, giggity, goo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GGT_40d9b6f50d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

