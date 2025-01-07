module 0x5c7ef6ba8ecebbe548adbebe4c8bf908184d556dc1b0e4e08bec7ab5fe2de3ee::mnc {
    struct MNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNC>(arg0, 6, b"MNC", b"Mac N Cheese", x"57656c636f6d6520746f2061206368656573792070726f6a656374206469726563746c792066726f6d207468652063686565737920646570746873206f662074686520537569204e6574776f726b2e20202020202068747470733a2f2f742e6d652f4d61634e4368656573655375690a68747470733a2f2f6d61636e6368656573657375692e63617272642e636f2f0a68747470733a2f2f782e636f6d2f6d61636e636865657365737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/single_serve_mac_n_cheese_dd8a05e4c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

