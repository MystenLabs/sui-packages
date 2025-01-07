module 0x958052b9df066c6c61c92291bb1864b61c1ef3d047ae4e0bf78d20a686519ab9::usacoin {
    struct USACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USACOIN>(arg0, 9, b"USACOIN", b"USACOIN on SUI", b"USACOIN (USACOIN)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXRcVnCB5thyPaLKPo4zsfoow38sgSxza9fihG31zfUBT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USACOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USACOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USACOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

