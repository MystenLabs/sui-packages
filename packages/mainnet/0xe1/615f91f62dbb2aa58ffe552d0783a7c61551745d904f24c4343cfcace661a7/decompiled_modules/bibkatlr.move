module 0xe1615f91f62dbb2aa58ffe552d0783a7c61551745d904f24c4343cfcace661a7::bibkatlr {
    struct BIBKATLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKATLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKATLR>(arg0, 9, b"BIBKATLR", b"Bibka", b"Bibka can bio bip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/562b6889-7f32-40b5-b7ee-b5f7d5554974.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKATLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKATLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

