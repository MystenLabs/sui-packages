module 0xdf3d9290cf6f7b7ff4f18a5c4532b78b823c5001087d90c012697e4ce50badaf::jameel {
    struct JAMEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMEEL>(arg0, 9, b"JAMEEL", b"JameelToken", b"A token created by UpLLM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAMEEL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMEEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

