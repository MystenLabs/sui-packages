module 0xab097f9411b0e6db9dfd0796fc1571a1032d35455fad3ef46beeaf61fd61d28::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"Axo", b"AxoOnSui", b"Axo the Axolotl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pink_0235699710.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

