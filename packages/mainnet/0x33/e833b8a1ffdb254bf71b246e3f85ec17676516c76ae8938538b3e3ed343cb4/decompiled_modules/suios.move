module 0x33e833b8a1ffdb254bf71b246e3f85ec17676516c76ae8938538b3e3ed343cb4::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 6, b"SuiOS", b"SuiOS", b"Future of DEX trading on Sui Ignited by the fiery spirit of SuiOS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/QmdXg1BaAaq3UNbenGKZZnyL8dqNUyQbdgj8XWd4ab9RDq")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIOS>>(0x2::coin::mint<SUIOS>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIOS>>(v2);
    }

    // decompiled from Move bytecode v6
}

