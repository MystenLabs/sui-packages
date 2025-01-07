module 0xec019fa807e698551908fca61744702bb254aeb39e693326524eec9ac0f13c8c::babydizzy {
    struct BABYDIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDIZZY>(arg0, 6, b"BabyDizzy", b"Baby Dizzy on Sui", b"Baby Dizzy is a unique and adorable digital collectible on the Sui blockchain. Each Baby Dizzy is a one-of-a-kind representation of a cute and quirky baby animal Dizzy, designed to bring joy and delight to NFT collectors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7342_47b17465bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

