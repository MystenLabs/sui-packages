module 0x8d8c4b9ccbe0d1ce61e53a0645a8690966a9302fed28c6215440d7f545d55a4b::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 6, b"SUICUNE", b"SUICUNE the Beast Water type Pokemon", b"$SUICUNE is one of the legendary beast Pokemon. A water type also known as Aurora Pokemon that will shine in $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6p5jqu2klrb5sbcx5ohgko6fthgtrztvlyccoyvesg3wqpttdya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

