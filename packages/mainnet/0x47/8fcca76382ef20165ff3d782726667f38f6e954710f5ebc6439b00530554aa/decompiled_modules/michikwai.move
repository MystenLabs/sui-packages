module 0x478fcca76382ef20165ff3d782726667f38f6e954710f5ebc6439b00530554aa::michikwai {
    struct MICHIKWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHIKWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHIKWAI>(arg0, 6, b"MICHIKWAI", b"Sui Michikwai", b"Building $MICHIKWAI brick by brick  and theres no room for paper hands", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yihglh_f01a7c5da2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHIKWAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHIKWAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

