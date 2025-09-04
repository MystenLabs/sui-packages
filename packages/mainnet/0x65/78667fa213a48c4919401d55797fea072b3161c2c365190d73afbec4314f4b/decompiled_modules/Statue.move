module 0x6578667fa213a48c4919401d55797fea072b3161c2c365190d73afbec4314f4b::Statue {
    struct STATUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STATUE>(arg0, 9, b"STATUE", b"Statue", b"solid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz9J4zTaQAA1RQE?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STATUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

