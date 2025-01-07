module 0xfe03b50c70080618a6394ef8572aa5b21241210f4f7a75bd11194abf3c64dd79::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEED>(arg0, 6, b"SEED", b"SEED", b"No.1 Play2Earn Telegram Miniapp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXkVde4AVDnwcNAupToHuCmx6dEbf2WwNqMM9f4VmhV2k")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEED>>(v1);
        0x2::coin::mint_and_transfer<SEED>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

