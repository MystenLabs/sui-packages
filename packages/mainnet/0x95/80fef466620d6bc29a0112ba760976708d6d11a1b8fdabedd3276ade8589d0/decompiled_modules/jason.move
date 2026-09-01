module 0x9580fef466620d6bc29a0112ba760976708d6d11a1b8fdabedd3276ade8589d0::jason {
    struct JASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/51387-kVJIqmBBjiixloO2o2thEyODQnbHdG.webp";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/51387-kVJIqmBBjiixloO2o2thEyODQnbHdG.webp"))
        };
        let (v2, v3) = 0x2::coin::create_currency<JASON>(arg0, 9, b"JASON", b"JASON DUVAL", x"224a61736f6e2077616e747320616e2065617379206c6966652c20627574207468696e6773206a757374206b6565702067657474696e67206861726465722e220a0a582068747470733a2f2f782e636f6d2f4754416c706861696e74656c", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JASON>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASON>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<JASON>>(0x2::coin::mint<JASON>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

