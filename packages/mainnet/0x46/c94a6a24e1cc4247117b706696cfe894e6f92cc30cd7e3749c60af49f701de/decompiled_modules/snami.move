module 0x46c94a6a24e1cc4247117b706696cfe894e6f92cc30cd7e3749c60af49f701de::snami {
    struct SNAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAMI>(arg0, 6, b"SNAMI", b"Suinami", b"SUINAMI SUINAMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqtyrlygotsirnt74nkcxinq2ovql4qgz2jm3wfnhglnid7jtjdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNAMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

