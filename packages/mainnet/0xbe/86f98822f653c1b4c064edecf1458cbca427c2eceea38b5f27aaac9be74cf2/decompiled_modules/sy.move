module 0xbe86f98822f653c1b4c064edecf1458cbca427c2eceea38b5f27aaac9be74cf2::sy {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SY>(arg0, 6, b"Sy", b"Habibi", b"Habibi welcome to Damascus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061047_a4db0abefb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SY>>(v1);
    }

    // decompiled from Move bytecode v6
}

