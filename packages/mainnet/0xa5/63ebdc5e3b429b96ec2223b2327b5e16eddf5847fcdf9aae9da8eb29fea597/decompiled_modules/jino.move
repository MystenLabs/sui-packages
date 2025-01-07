module 0xa563ebdc5e3b429b96ec2223b2327b5e16eddf5847fcdf9aae9da8eb29fea597::jino {
    struct JINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINO>(arg0, 6, b"Jino", b"Jimmy and Nova", b"CUTE TWIN DOGS ON SUI ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000153067_dbdfc6f919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

