module 0x43b6dab910fd8d75769150fbe598baa1532f36e5f46831b6b5b6f0a4bfb5934d::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUIMEN", b"If It Doesn't Taste Like $SUIMEN, I'm Not Buying It. :3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_04_56_07_2_b29666f893.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

