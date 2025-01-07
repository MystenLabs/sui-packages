module 0x468cad44a3b7a55a90ff33a5993d3a382604743622dc6dd5dce251281bf4df85::abbabdbd {
    struct ABBABDBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABBABDBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABBABDBD>(arg0, 9, b"ABBABDBD", b"Abdvdv", b"Hdshsbbs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cf8af65-d257-4188-9799-f176e8aa087d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABBABDBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABBABDBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

