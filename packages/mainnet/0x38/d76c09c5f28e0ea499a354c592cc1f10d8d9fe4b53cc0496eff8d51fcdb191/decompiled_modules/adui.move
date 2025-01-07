module 0x38d76c09c5f28e0ea499a354c592cc1f10d8d9fe4b53cc0496eff8d51fcdb191::adui {
    struct ADUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADUI>(arg0, 9, b"ADUI", b"adu", b"ADUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f92f95c-597f-49ba-9ac1-86e8f91fa338.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

