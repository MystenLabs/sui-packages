module 0x65689b56ba575a7a30b64877babd9e43bd971dadfe0fd6b85ad8a1f00f6cf37b::basc {
    struct BASC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASC>(arg0, 6, b"BASC", b"Bored Ape Sui Club", b"Bored Apes, On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002852_2d31d760eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASC>>(v1);
    }

    // decompiled from Move bytecode v6
}

