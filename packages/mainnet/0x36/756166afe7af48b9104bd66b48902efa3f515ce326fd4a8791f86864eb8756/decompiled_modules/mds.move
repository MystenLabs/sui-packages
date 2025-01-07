module 0x36756166afe7af48b9104bd66b48902efa3f515ce326fd4a8791f86864eb8756::mds {
    struct MDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDS>(arg0, 6, b"MDS", b"mondosui", b"mondo on sui - inspired by mondo sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OGKL_3p_XD_400x400_33a706c349.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

