module 0x1c6e37857ba577e200220716ce2560d69c24b8bebb45b3d817f9e1ed5600d6d5::bay {
    struct BAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAY>(arg0, 9, b"BAY", b"Tokenbay", b"Baytokenbay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff782ab9-ba1a-4179-8573-36029a9e6073.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

