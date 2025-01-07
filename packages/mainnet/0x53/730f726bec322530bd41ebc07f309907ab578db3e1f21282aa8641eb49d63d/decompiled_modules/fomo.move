module 0x53730f726bec322530bd41ebc07f309907ab578db3e1f21282aa8641eb49d63d::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"Fear Of Missing Out", b"At FOMO, we are not just token; we are an atmosphere, a movement that thrives on the thrill of new beginnings and not getting left behind..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_51a2688ffa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

