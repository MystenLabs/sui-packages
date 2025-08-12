module 0xca77e1b5db5ca8bf37b9df67096a3eeb84a4a353d41fafc9c6c074fe9e02eac3::adison {
    struct ADISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADISON>(arg0, 6, b"ADISON", b"Adison On Sui", b"From Suipringfield to the $SUI frontlines", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd74vqrb7etdcuyrxaapu7uvqw3w327scucvgpfti7dmchtn4xpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADISON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

