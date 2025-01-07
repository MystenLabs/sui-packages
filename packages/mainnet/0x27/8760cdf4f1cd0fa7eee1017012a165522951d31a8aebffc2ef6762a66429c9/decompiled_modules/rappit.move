module 0x278760cdf4f1cd0fa7eee1017012a165522951d31a8aebffc2ef6762a66429c9::rappit {
    struct RAPPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPPIT>(arg0, 9, b"RAPPIT", b"MC Rappit", b"Fucking legend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/478/894/large/emmanuel-luiz-rappit.jpg?1727701739")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAPPIT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPPIT>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

