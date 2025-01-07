module 0x72b954419ffa76db7a9696409559d4708eaedbc0890c4e5bdbd2bc9ec59201a2::dippy {
    struct DIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIPPY>(arg0, 6, b"Dippy", b"DippySui", b"Take a dip in the meme pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_084942270_cc8096ff80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

