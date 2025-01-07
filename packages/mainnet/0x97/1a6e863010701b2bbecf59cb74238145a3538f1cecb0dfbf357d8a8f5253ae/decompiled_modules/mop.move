module 0x971a6e863010701b2bbecf59cb74238145a3538f1cecb0dfbf357d8a8f5253ae::mop {
    struct MOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOP>(arg0, 9, b"MOP", b"CC.1", b"CC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6441cee7-eca9-4428-9730-0243b24669e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

