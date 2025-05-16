module 0x87b68be1c162009ef450ba860099e9efa2de0b51600c81cefe703d48e15181a3::fartsui {
    struct FARTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTSUI>(arg0, 9, b"FARTSUI", b"FARTSIGHT ON SUI", x"57616e7420666172742d646574656374696e6720676c61737365733f0a0a476f6f642e0a0a456163682046617274536967687420756e697420636f7374732065786163746c79203120244641525453494748542e0a0a4e6f205355492e204e6f20555344542e204e6f20657863757365732e0a496620796f752077616e7420746f20736565207468652074727574682c20796f756c6c206e65656420746f2062656c6965766520696e2069742066697273742e0a406c61756e6368636f696e200a24464152545349474854202b4641525453494748542068747470733a2f2f742e636f2f456c304f755a39646a42", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigb25bgdqrrywtc4rqaeej2gfhurwtjpeistcfptunrftprgp32ye")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FARTSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

