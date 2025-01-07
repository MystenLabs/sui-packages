module 0x4cda3d38c3519e14f2dfeea26dae073c5efdd0506a1e4229c9ed1b8bbe7a2b38::munky {
    struct MUNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKY>(arg0, 9, b"Munky", b"Munky Cat", x"4d756e6b792063617420697320746865207075726520656d626f64696d656e74206f6620707572652064697362656c69656620616e6420636f6e667573696f6e2e20244d756e6b7920697320757320616e642077652061726520616c6c20244d756e6b790d0a0d0a436f6f6b20736f6d65206d656d657320757020666f722062726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/65wwCdZaHvWLXKh7bZQDaRsY7yRj97sX9VDyGXMXpump.png?size=xl&key=2d7825")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUNKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

