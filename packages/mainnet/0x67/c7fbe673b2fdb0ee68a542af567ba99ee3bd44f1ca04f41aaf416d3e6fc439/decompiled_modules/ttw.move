module 0x67c7fbe673b2fdb0ee68a542af567ba99ee3bd44f1ca04f41aaf416d3e6fc439::ttw {
    struct TTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTW>(arg0, 6, b"TTW", b"TuskWalrusOnSui", b"Walrus Cult of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tusk_1399f58dc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

