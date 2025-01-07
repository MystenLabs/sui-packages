module 0xde4b023dabb0b4d56f23ae8dbae2f7429b6b666bc54256837e6e7bca57a4a4b3::rootwif {
    struct ROOTWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOTWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOTWIF>(arg0, 6, b"RootWIF", b"Root Wif Hat", b"Root Wif Hat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/download_6_021c483d00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOTWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOTWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

