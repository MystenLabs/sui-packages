module 0x14507e5acc37852a927f45799ebd67c90a832ce5b767483a64db1769ef754ea5::tuskar {
    struct TUSKAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSKAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSKAR>(arg0, 6, b"TUSKAR", b"TUSKARONSUI", b"First Launchpad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaeflltmxiinrdhn3cbqzoybs5sjixtjnrijgeg3rftmwwcqhm4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSKAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUSKAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

