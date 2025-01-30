module 0x55269e8751b7d1a93960fea8985355acff77f2cdf685381d24791d480b173f29::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"PUMP", b"TelePumpFun.com", b"Telegram Generated Memes.  Leave trenches and stay on telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWm9SwyrHGP7roSEmhZFBpdgwuNtQ2oPbRwXEn5fhbL9G")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

