module 0x39af818f9f2cbecf8732834a3d88adb2ee4e7807aae309a5be0a52886b49abf5::stupidcoin {
    struct STUPIDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUPIDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUPIDCOIN>(arg0, 9, b"Stupidcoin", b"Stupidcoin on SUI", b"#stupidcoin, a digital masterpiece of pure absurdity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSs4ofsWv8tYfMWAJYCZYBTnQN7fboeemHqFUqWAdBAS8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STUPIDCOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STUPIDCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUPIDCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

