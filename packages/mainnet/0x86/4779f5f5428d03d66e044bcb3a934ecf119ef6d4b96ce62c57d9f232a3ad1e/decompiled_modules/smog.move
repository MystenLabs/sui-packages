module 0x864779f5f5428d03d66e044bcb3a934ecf119ef6d4b96ce62c57d9f232a3ad1e::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 9, b"SMOG", b"Smol Dog", b"If you like Dogs then you will fall in love with $SMOG  https://t.me/sui_smongdog  https://x.com/sui_smongdog  https://smoldog.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/smoldogsui/smog/refs/heads/main/photo_2024-10-16_22-28-24.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

