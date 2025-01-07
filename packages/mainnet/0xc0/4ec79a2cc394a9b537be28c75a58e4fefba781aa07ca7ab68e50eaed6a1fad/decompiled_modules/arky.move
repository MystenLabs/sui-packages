module 0xc04ec79a2cc394a9b537be28c75a58e4fefba781aa07ca7ab68e50eaed6a1fad::arky {
    struct ARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARKY>(arg0, 6, b"ARKY", b"Arky", b"What happens when people realize its not $sasha but $arky who is the real satoshi pet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009719_a04cc524be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

