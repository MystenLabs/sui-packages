module 0x3255e3327b000cca4fba2c0592c40f0e08ad73443f3115973bfd9b5a7285d5a7::huhu {
    struct HUHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUHU>(arg0, 9, b"HUHU", b"Taongo", b"Hihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ce89689-6bf1-431d-9fa1-cbcdb8db8f9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

