module 0x3abe1d26fb0b71c9c02e7f4116c3ebdbda3ef718d75056eaf6f151f62227eefc::sufi {
    struct SUFI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUFI>>(0x2::coin::mint<SUFI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUFI>(arg0, 8, b"SUFI", b"sufi", b"sufi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUFI>>(0x2::coin::mint<SUFI>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

