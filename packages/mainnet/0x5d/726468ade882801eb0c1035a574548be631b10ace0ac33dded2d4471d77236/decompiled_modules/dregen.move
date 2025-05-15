module 0x5d726468ade882801eb0c1035a574548be631b10ace0ac33dded2d4471d77236::dregen {
    struct DREGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREGEN>(arg0, 6, b"Dregen", b"DREGEN SUI", b"Dregen. The gambling addicted dragon on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifeq35r76dyxn5ckswhm2nwaxcpm5agiew3zi6ab7dpovrbu2qhbm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DREGEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

