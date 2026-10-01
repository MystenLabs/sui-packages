module 0xa226e9af8c1b865ce1f027542808214688d8878d3f493877b2a45aa5e3e3aace::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YOLO>(arg0, 6, 0x1::string::utf8(b"YOLO"), 0x1::string::utf8(b"YOLO"), 0x1::string::utf8(b"A grainy nighttime phone photo of a guy standing on a concrete rooftop ledge, arms thrown wide, mouth open mid-yell, city lights blurred behind him. Big white Impact text at the bottom reads YOLO."), 0x1::string::utf8(b"https://popularsui.xyz/media/a7bc79a9959f706131f47c02bbc4b1a24893df2689a6040aef0d95ebe983a19b.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YOLO>>(0x2::coin_registry::finalize<YOLO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

