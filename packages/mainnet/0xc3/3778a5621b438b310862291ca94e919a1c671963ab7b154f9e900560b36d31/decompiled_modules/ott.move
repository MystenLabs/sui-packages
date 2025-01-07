module 0xc33778a5621b438b310862291ca94e919a1c671963ab7b154f9e900560b36d31::ott {
    struct OTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTT>(arg0, 9, b"OTT", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c41d1233-9398-4ca6-b683-503038b05bfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

