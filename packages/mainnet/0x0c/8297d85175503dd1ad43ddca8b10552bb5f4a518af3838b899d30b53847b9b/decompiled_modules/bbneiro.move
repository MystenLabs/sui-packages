module 0xc8297d85175503dd1ad43ddca8b10552bb5f4a518af3838b899d30b53847b9b::bbneiro {
    struct BBNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBNEIRO>(arg0, 6, b"BBNEIRO", b"BABY NEIRO SUI", b"Neiro's True Successor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xbabe3ce7835665464228df00b03246115c30730a_2e53bda285.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

