module 0x2b8b34f91d414d29bb498399f271bd5b689a30a6dd585d99f2c7d1c352f4d0ff::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"TEAM ROCKET", x"746865206f6e6c7920616e64206c65676974205445414d20524f434b45542020746865207469636b65722069732024726f636b65740a0a5465616d2024524f434b455420466f72676564206f6e207468652024535549204e6574776f726b2e204d656d65206d61676963206d65657473207265616c2d776f726c64206d61747465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreift5xopo4fnzbi5pzpb746hyhhrtbi3bdcsgrqdq2e7s4oiaap3qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

