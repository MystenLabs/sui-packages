module 0xe2714f6fd5900fdbb6faad3733ca9dc711a6ca11a89046d92737201d3a7dd3f3::pba {
    struct PBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBA>(arg0, 6, b"PBA", b"Pumbaa the Suidea", b"We all know Pumbaa and we all love him. Lets bring him to sui. website, TG and X going live at 16. Oct 6pm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5655_36fc32cfb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

