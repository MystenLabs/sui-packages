module 0xbc0388ba5aa987864f57719f5739031796adf598222a769e1f91d29df3d972e7::sui_tron_kelar {
    struct SUI_TRON_KELAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_TRON_KELAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TRON_KELAR>(arg0, 9, b"SUI TRON KELAR", b"SUITRON", b"SUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII AREEB AREEBA ANGARE ANGARE GOOOOALLLLLLLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmQFkLRz9BZ6ACTAHeyVxa2edtJQD1S4Ti3j8Hi8K9Q1YY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_TRON_KELAR>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TRON_KELAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_TRON_KELAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

