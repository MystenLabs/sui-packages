module 0xf91c14883a094d8575adf97004d5de4bfbac9fe337a76bbb63b1c7c1ceb91977::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAO>(arg0, 6, b"DAO", b"Drunk Autistic Optimus", b"Drunk Autistic Optimus on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dao_1b0f87ab07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

