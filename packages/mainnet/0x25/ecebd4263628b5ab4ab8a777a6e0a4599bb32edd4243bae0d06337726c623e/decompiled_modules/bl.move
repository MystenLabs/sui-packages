module 0x25ecebd4263628b5ab4ab8a777a6e0a4599bb32edd4243bae0d06337726c623e::bl {
    struct BL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BL>(arg0, 9, b"BL", b"Babylook ", x"42616279206973206c6f6f6b696e6720f09f918020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18629cb9-cf08-46a4-910c-966bc36dc515.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BL>>(v1);
    }

    // decompiled from Move bytecode v6
}

