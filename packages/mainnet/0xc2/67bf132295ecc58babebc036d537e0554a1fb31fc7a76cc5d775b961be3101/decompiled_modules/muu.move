module 0xc267bf132295ecc58babebc036d537e0554a1fb31fc7a76cc5d775b961be3101::muu {
    struct MUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUU>(arg0, 6, b"MUU", b"muu", b"Thank you for finding Mew! The cutest and most viral cat on TikTok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/un_IP_Mq8_3aa2101b2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

