module 0x4099b9a7c997e869e224623912e08a5025409dd3227fba8d6179333506fd9c6a::bibkatlr {
    struct BIBKATLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKATLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKATLR>(arg0, 9, b"BIBKATLR", b"Bibka", b"Bibka can bio bip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d80ce223-ac4f-44d2-9f6e-f8048a05bd92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKATLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKATLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

