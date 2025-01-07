module 0x8e3df3ff10db0aac0e414f1df7539f2c4db643b123c674e0601f17e85ff63752::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 9, b"SUILION", b"Sui Lion", b"Sui Lion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmTfj3C6G1A7RzT5vjRe5zrDvCUAPhX77ciNCBAqo6bwCT"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILION>>(v1);
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 1000000000000000000, @0x643d0251673c9c3b4c3c0996f825a2ada36913965dda7ee1907b1c87706fc1c5, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUILION>>(v2);
    }

    // decompiled from Move bytecode v6
}

