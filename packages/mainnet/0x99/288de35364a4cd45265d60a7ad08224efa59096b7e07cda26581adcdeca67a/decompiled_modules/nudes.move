module 0x99288de35364a4cd45265d60a7ad08224efa59096b7e07cda26581adcdeca67a::nudes {
    struct NUDES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUDES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUDES>(arg0, 9, b"NUDES", b"just send", b"just send (nudes)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ADi9GqcecN2Um8qqEhKa1UZx9hHmDx7XJUGFcormpump.png?size=xl&key=4f56f1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUDES>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUDES>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUDES>>(v1);
    }

    // decompiled from Move bytecode v6
}

