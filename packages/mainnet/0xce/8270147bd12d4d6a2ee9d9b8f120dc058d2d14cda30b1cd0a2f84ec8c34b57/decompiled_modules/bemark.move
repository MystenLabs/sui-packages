module 0xce8270147bd12d4d6a2ee9d9b8f120dc058d2d14cda30b1cd0a2f84ec8c34b57::bemark {
    struct BEMARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEMARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEMARK>(arg0, 9, b"BEMARK", b"BM", b"Ready to go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e128b019-e8d1-4f63-a486-d486712173a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEMARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEMARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

