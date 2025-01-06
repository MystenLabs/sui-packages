module 0xb2761783acabb97c8ea8be8f2b9bc2217c09f119604acf436bc4055e80220575::tos {
    struct TOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOS>(arg0, 6, b"TOS", b"The Titans", b"Titans of SUI | Armored in strength, united in vision. Defenders of innovation and builders of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5061_d2e21ff75f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

