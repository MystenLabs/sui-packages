module 0xcefa4f6e26f30d67ed1ce8dc1f441817d6a35110492e986832351afc8b29b723::stw {
    struct STW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STW>(arg0, 6, b"STW", b"SuiVault Wallet", b"SuiVault The Smartest Wallet for the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiah7csyuiy43fbadgjzjppxo3tdvylvdo24kymx26q5zhygjqsjyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

