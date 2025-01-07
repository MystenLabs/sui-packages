module 0x1974481fc0c2e7016fb060750282df7c6a0b3e421f87eb684c4d8f63c23b8bbe::nrt {
    struct NRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRT>(arg0, 9, b"NRT", b"Naruto", b"In honor of the great Uzumaki naruto and his shinobi way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bde9fb4-8673-4a0c-a707-77fba32867f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

