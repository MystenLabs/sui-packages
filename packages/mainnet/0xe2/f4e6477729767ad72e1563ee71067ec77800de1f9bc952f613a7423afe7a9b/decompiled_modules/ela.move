module 0xe2f4e6477729767ad72e1563ee71067ec77800de1f9bc952f613a7423afe7a9b::ela {
    struct ELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELA>(arg0, 6, b"ELA", b"Elon ape", b"Elon ape presale, combining the animal narrative with Elon musk as the character, VC would be live soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6637_ac3baf7c13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

