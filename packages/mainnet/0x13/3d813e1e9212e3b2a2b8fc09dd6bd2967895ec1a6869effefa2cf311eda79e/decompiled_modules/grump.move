module 0x133d813e1e9212e3b2a2b8fc09dd6bd2967895ec1a6869effefa2cf311eda79e::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMP>(arg0, 6, b"GRUMP", b"GrumpyCat", b"Yaaas, get ready!  Grumpy Cat is taking over Web3 and it's about to get messy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_41b3801e64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

