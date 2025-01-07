module 0xb9dad842d1164225c5abdbe841e92ac9b619c0afb78db0e9be865d4edf138787::carb {
    struct CARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARB>(arg0, 9, b"CARB", b"bluecar", x"546865206578636974656d656e74206f66207468652063617220776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeab7906-2930-4789-b235-bfdff47f5bcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARB>>(v1);
    }

    // decompiled from Move bytecode v6
}

