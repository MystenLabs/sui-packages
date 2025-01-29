module 0x7f32f2f469bea895b5fa756dbcb2da59c6ca3e88767777d201c4a41487d5fae0::python {
    struct PYTHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYTHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYTHON>(arg0, 9, b"PYTHON", b"Chinese New Year Mascot", b"$PYTHON is the silent hunter of wealth, striking with precision in 2025, the Year of the Snake. This memecoin on Solana is ready to squeeze out weak hands and reward those who dare to hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYJUz2Af8ATooqNZB3AAt5MnQyCejkuzoMdU8nVwPzruJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PYTHON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYTHON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYTHON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

