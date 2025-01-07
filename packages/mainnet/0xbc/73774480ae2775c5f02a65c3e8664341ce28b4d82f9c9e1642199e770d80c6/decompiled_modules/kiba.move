module 0xbc73774480ae2775c5f02a65c3e8664341ce28b4d82f9c9e1642199e770d80c6::kiba {
    struct KIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBA>(arg0, 6, b"KIBA", b"Kiba Sui", b"$KIBA is the most unique and lucky dog in the Sui Ocean, who remains true to his roots and brings wealth and dynamic energy to the Sui Network. With the legend of the legendary white dog, $KIBA symbolizes prosperity and joy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001500_4ed7c00b24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

