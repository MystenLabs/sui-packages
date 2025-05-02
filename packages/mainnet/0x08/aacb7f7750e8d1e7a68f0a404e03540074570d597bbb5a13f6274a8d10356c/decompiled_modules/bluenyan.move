module 0x8aacb7f7750e8d1e7a68f0a404e03540074570d597bbb5a13f6274a8d10356c::bluenyan {
    struct BLUENYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUENYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUENYAN>(arg0, 6, b"BLUENYAN", b"Blue Nyan Cat on Sui", x"576174696e6720666f7220746865206269672067656d3f0a5768793f0a5765206861766520426c7565204e79616e20436174206f6e205375692e200a456e6a6f7920746865207269646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidg4x2mjzu7y4ybyjtmapd4zljcgabl5vudckm6ouiyty24p4up3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUENYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUENYAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

