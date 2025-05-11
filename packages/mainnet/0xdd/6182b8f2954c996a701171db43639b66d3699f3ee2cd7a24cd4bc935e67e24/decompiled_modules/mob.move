module 0xdd6182b8f2954c996a701171db43639b66d3699f3ee2cd7a24cd4bc935e67e24::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"Marvin Only Boy", x"4d6f6220746865205175696574657374204578706c6f73696f6e206f6e20535549205468650a637574657374206d656d65206372656174757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068805_0fe939bb68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

