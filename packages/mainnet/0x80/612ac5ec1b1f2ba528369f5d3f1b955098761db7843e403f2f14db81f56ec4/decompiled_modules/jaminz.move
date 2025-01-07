module 0x80612ac5ec1b1f2ba528369f5d3f1b955098761db7843e403f2f14db81f56ec4::jaminz {
    struct JAMINZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMINZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMINZ>(arg0, 9, b"JAMINZ", b"Momo", b"A cat saying mo~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/354d803a-517d-479b-9d3d-a344e65ceefe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMINZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMINZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

