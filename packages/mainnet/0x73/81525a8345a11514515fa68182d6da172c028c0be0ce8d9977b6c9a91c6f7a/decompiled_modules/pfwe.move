module 0x7381525a8345a11514515fa68182d6da172c028c0be0ce8d9977b6c9a91c6f7a::pfwe {
    struct PFWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFWE>(arg0, 9, b"PFWE", b"PAFOWE ", b"Community driven token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cacbfa7c-313f-439f-a35f-a94aa92d57da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PFWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

