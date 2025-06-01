module 0xb46f1693c12faa7c04633ec6fa75b12142af0c3b600a6302addc978bd04be1eb::nani {
    struct NANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANI>(arg0, 6, b"Nani", b"Nani on Sui", x"41206d656d6520636f696e206f6e205375692c20706f77657265642062792076696265732c206d656d65732c20616e642074686520647265616d206f66206d616b696e672069742e204e6f20726f61646d61702e204e6f2070726f6d697365732e204a757374205375692d6c6c792066756e2e20f09f9a80f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748772836925.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

