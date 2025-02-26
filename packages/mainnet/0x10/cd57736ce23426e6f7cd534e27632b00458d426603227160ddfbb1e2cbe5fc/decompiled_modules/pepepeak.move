module 0x10cd57736ce23426e6f7cd534e27632b00458d426603227160ddfbb1e2cbe5fc::pepepeak {
    struct PEPEPEAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPEAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPEAK>(arg0, 6, b"PepePeak", b"PepePeak On Sui", b"Together create funny memes, images and videos about Pepe, spreading the community's spirit of optimism and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_26_09_46_56_9fb32565ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPEAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEPEAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

