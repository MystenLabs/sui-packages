module 0x34b73fa782f97da0a98d2175c02f1e7495d03ae218f391874b5ae457cefb9268::scorp {
    struct SCORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCORP>(arg0, 9, b"SCORP", b"SCORPION", b"Mem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddfc6935-1d44-4d52-ab12-ea816d9b8b1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

