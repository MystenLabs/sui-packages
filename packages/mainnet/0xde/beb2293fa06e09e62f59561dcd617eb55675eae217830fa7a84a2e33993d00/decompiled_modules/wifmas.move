module 0xdebeb2293fa06e09e62f59561dcd617eb55675eae217830fa7a84a2e33993d00::wifmas {
    struct WIFMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAS>(arg0, 9, b"wifmas", b"wifmas wifmas", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreie6it5d3j46qag3yv3dqx2e5gut5bahvbaw5q55j3q2s5tsazdlke.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIFMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

