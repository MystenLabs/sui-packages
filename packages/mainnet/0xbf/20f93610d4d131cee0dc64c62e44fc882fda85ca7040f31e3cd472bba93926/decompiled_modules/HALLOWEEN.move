module 0xbf20f93610d4d131cee0dc64c62e44fc882fda85ca7040f31e3cd472bba93926::HALLOWEEN {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"HALLOWEEN", b"Halloween", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/990/815/large/pierre-armal-le-halloween-copie2.jpg?1729087058")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HALLOWEEN>>(0x2::coin::mint<HALLOWEEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HALLOWEEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

