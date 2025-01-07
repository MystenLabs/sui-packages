module 0x4ff490da2f4b5856ed0d0b423f417b2f61829d0594fd29c8fecdaf102849d73d::axl {
    struct AXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXL>(arg0, 9, b"AXL", b"Axolotl", b"Axolotl in minecraft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a4051cd-44ad-4ba6-8aa9-5c2021203449.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

