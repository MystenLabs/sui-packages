module 0x9e97196479a4e27d8f036484e6a12f36ef6d205bcf89c2d440a38e9af0b9893::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DRAGONSUI", b"Im the Dragon of Sui chain, RAWRRRRRRRRR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dragon_sui_5f933db8fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DS>>(v1);
    }

    // decompiled from Move bytecode v6
}

