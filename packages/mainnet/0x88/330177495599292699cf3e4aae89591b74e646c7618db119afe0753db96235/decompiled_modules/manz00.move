module 0x88330177495599292699cf3e4aae89591b74e646c7618db119afe0753db96235::manz00 {
    struct MANZ00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANZ00, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANZ00>(arg0, 9, b"MANZ00", b"manz", b"bajingan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a91e6720-d919-48f2-97ab-9891840b3b00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANZ00>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANZ00>>(v1);
    }

    // decompiled from Move bytecode v6
}

