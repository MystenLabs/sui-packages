module 0x9a3afdd1b1d56d8add038444a6d37f69d53cc71a5b71d1d6606ccc5b2907ba88::oene {
    struct OENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENE>(arg0, 9, b"OENE", b"hebe", b"vdbs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c9d5757-da3c-4a11-8d13-dc69736a4c95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

