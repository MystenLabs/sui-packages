module 0xe78a1db6af15560639200c1b63c0ca23be04404d87263a7041f02726b6b0fbfb::yos {
    struct YOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOS>(arg0, 9, b"YOS", b"YE on SUI", b"YE is a big fan of SUI more than the bullshit Solana, NOW ITS YOUR CHANCE TO GET SOME | Website: https://api.interestlabs.io/files/ebe7d4bde08b79eca9b912341f198147a4f58a75c6b4a813.webp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/ebe7d4bde08b79eca9b912341f198147a4f58a75c6b4a813.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

