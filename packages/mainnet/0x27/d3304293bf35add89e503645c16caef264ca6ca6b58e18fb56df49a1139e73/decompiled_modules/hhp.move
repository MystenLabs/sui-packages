module 0x27d3304293bf35add89e503645c16caef264ca6ca6b58e18fb56df49a1139e73::hhp {
    struct HHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHP>(arg0, 9, b"HHP", b"HIPHOP", x"486970486f70204172746973740a22597568616e6e612220497320486970486f702053696e6765722c20536f756e6420456e67696e6565722c20436f6d706f7365722c20536f6e672057726974657220616e6420466f756e6465722f536f6c6f204f776e6572206f6620c2a9597568616e6e61c2a0205265636f7264204c6162656c0a46756c6c204c6567616c204e616d65203a2053616a6a6164204a616d7368696469204d6f6768616464616d0a436f7079726967687420323030392d50726573656e7420c2a9597568616e6e612050504c2c20416c6c207269676874732072657365727665642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eda41a6-5091-4d5a-85eb-e913bfa22494.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

