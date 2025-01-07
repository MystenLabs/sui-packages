module 0x6b8d122f1358f0570b0472cafdf72c9c22498d9621eb37be5788d0807e1f7bd5::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"D.O.G.E", b"UX/UI and Graphic Designer/Citizen Journalist at Dogecoin and MyDoge Inc. DOGE will also be the first MEME coin on SUI, let us witness its ascent together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C2_V_fbll_400x400_de8b9f4013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

