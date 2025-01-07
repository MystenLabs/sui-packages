module 0x738412d14fee0dff9a0090dd3d897409afe217cdb840c1510a5c385445058d9f::dropai {
    struct DROPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPAI>(arg0, 6, b"DropAI", b"SUI Drop by Claude", b"A water droplet created by Claude Ai.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0043_c13f57e4b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

