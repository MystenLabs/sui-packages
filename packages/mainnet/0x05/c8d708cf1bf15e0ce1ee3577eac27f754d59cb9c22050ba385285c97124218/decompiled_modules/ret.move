module 0x5c8d708cf1bf15e0ce1ee3577eac27f754d59cb9c22050ba385285c97124218::ret {
    struct RET has drop {
        dummy_field: bool,
    }

    fun init(arg0: RET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RET>(arg0, 9, b"RET", b"rainbow", b"seven colors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21220f64-88ef-4b34-8ea0-8446f2a90128.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RET>>(v1);
    }

    // decompiled from Move bytecode v6
}

