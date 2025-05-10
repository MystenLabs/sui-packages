module 0x422b3fc82c88c5a5bd383c09c068a5f20d5e10eb2c012e35a9049f1854009677::moonshot {
    struct MOONSHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSHOT>(arg0, 6, b"MOONSHOT", b"Moonshot On Sui", b"we are moonshot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifswnbdafeeszzhe7sjhdxl33vnc4wg7f2lr5smgvfuld566rna5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONSHOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

