module 0x2a96ec0c58f6f3c7029899560af7c3ecadc6f81cf081ffca6ea07bf03c785922::sbob {
    struct SBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOB>(arg0, 6, b"SBOB", b"SPONGEBOB", b"- Are they laughing at us?! - No, Patrick, they are laughing right next to us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spongebob_b7a26785bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

