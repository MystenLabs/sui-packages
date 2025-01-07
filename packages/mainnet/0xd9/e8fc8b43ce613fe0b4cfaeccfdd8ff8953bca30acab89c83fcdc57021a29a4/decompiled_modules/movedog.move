module 0xd9e8fc8b43ce613fe0b4cfaeccfdd8ff8953bca30acab89c83fcdc57021a29a4::movedog {
    struct MOVEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDOG>(arg0, 6, b"MOVEDOG", b"MOVE SEADOG", b"NEW CAPTAIN SEADOG MOVEPUMP IMO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3734_e15c73b6aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

