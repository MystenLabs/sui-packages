module 0x8318d3781154e377ff58d7ae2a400649b0e197e7a75ccc08190d0740b8747c4e::KAI {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 9, b"KriyaDEX", b"KriyaDEX", b"Kriya is building institutional grade infra for on-chain trading. The current suite includes - an in-app bridge, an AMM swap and a fully on-chain orderbook for 20x perp trading. OTC-RFQ functionality coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1644422575366475776/brtXlZ5n_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

