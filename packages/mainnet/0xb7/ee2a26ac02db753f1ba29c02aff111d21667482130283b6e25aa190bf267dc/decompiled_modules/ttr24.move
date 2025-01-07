module 0xb7ee2a26ac02db753f1ba29c02aff111d21667482130283b6e25aa190bf267dc::ttr24 {
    struct TTR24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTR24>(arg0, 6, b"TTR24", b"the tremp redemption 2024", b"A corrupt system is against the next US president, help us save trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_4741e1923b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTR24>>(v1);
    }

    // decompiled from Move bytecode v6
}

