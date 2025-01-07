module 0xa403a2728943c7a3fca91ad93f649e20e5bb323ae8e0e6bef76a0037fabf8ed4::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"BUCK", b"Buck The Bunny", b"Charged with meme power,  Bunny rules the Sui scene. $Buck the ultimate meme is here to lead te charge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_ed3af7e126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

