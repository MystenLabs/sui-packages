module 0xfc0340648e1f496f61fe4594f1b2000a8acc6502ffb81c90048ba9ec7eab64ca::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"SUINAMI", b"Suinami ", x"5375694e616d692069732074686520756e73746f707061626c65206d656d65636f696e20746964616c2077617665206f6e207468652053756920636861696ee28094726964696e6720686967682c206372617368696e6720686172642c20616e64207377656570696e672062616773206f66206761696e7320796f7572207761792e20506f77657265642062792070757265206d656d6520656e6572677920616e642074686520666f726365206f6620646563656e7472616c697a65642077617665732e204361746368206974206f7220676574207769706564206f75742120f09f8c8af09f92b020235375694e616d69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749668038358.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

