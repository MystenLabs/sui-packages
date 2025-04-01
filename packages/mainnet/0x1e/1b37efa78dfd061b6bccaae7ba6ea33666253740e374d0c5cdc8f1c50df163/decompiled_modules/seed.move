module 0x1e1b37efa78dfd061b6bccaae7ba6ea33666253740e374d0c5cdc8f1c50df163::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEED>(arg0, 9, b"SEED", b"0x1e005d033d858a39e1210aafdd139ce4fa21c79cdb8acadd16513a03c9d4cebd::seed::SEED", b"No.1 Play2Earn Telegram Miniapp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXkVde4AVDnwcNAupToHuCmx6dEbf2WwNqMM9f4VmhV2k")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEED>>(0x2::coin::mint<SEED>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEED>>(v2);
    }

    // decompiled from Move bytecode v6
}

