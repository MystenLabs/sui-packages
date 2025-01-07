module 0x4b509f15ddec08319ac3f8bbdf39ca045b26a3c81ee046faeada7f9741e91967::lmt {
    struct LMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMT>(arg0, 9, b"LMT", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3081fda-47d8-41cb-81d1-10212a2f49db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

