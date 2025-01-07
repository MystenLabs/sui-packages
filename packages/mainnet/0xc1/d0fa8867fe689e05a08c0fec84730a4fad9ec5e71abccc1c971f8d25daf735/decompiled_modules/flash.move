module 0xc1d0fa8867fe689e05a08c0fec84730a4fad9ec5e71abccc1c971f8d25daf735::flash {
    struct FLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLASH>(arg0, 9, b"FLASH", b"FLASH on SUI", b"Can't Have A Picture Without A Flash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfJXt5nP7FN8wTNARgXrenvix9rWuecgT2se16EvhdaWn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLASH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLASH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

