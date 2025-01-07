module 0x9d3ace63e3f554df2dfbf8ec6a035493dff3f41a77de7ba5853e1e7803c8a495::fsl {
    struct FSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSL>(arg0, 6, b"FSL", b"First Sui Lord", b"Head of the entire Sui Royal Navy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meme_1_sui_744fd31037.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

