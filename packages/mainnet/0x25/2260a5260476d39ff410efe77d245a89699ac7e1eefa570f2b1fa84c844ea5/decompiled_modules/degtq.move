module 0x252260a5260476d39ff410efe77d245a89699ac7e1eefa570f2b1fa84c844ea5::degtq {
    struct DEGTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTQ>(arg0, 9, b"DEGTQ", b"kloy", x"c4916667646667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e425648-1f26-4895-bb19-e50fd67e5f8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

