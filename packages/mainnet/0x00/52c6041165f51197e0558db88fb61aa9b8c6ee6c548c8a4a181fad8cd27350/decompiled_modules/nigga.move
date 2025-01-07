module 0x52c6041165f51197e0558db88fb61aa9b8c6ee6c548c8a4a181fad8cd27350::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 5, b"NIGGA", b"Nigga", b"The Nigganami is coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://p7.hiclipart.com/preview/899/522/503/nigger-nigga-kike-black-pol-nigger.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIGGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v2, @0x14024696163d5790f8b5d30fcf78a2f582e83679c7849fcf3d45786c0e50e186);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

