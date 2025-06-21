module 0xa981e9d8de22313c046cc660021c127c91418500d78dd92afbe8437973e2f2ec::cyne {
    struct CYNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYNE>(arg0, 8, b"CYNE", b"Cyber Neural Entity", b"The Leading LLM for Decentralized Crypto Intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/899454bc-780c-4389-aba1-503d842750a9.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYNE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYNE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

