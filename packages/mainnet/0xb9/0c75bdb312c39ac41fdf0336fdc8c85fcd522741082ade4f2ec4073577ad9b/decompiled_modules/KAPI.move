module 0xb90c75bdb312c39ac41fdf0336fdc8c85fcd522741082ade4f2ec4073577ad9b::KAPI {
    struct KAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPI>(arg0, 6, b"KAPI", b"Kapibarasan", b"Just a chill Kapibarasan on SUI chain. Kapilieve in something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://coffee-skilled-sawfish-754.mypinata.cloud/ipfs/QmWuLi8Amm6oEJQMKvQd8U3tvHMA4PfeRRSNnTqgKWUX2u"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAPI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAPI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KAPI>>(v2);
    }

    // decompiled from Move bytecode v6
}

