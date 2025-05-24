module 0xbceb62d213db61ec8fc74074711bdd88122afb381297e90c2badb7312e574c46::alf {
    struct ALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALF>(arg0, 6, b"ALF", b"Another Level of Fun", b"Meet ALF, Another Level of Fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihj7idtxavswjhenihzylmvncwe2tkmslpnymravkb5c6t5fmqppq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

