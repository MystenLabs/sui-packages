module 0x4c7536c342488d3c7dcb02c7e403bc1535b7accf8270a1999bb0e83989747557::dw {
    struct DW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DW>(arg0, 9, b"DW", x"446f6ee2809974576f727279", b"Best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba121920-891c-44c4-9b08-7fcc4841e160.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DW>>(v1);
    }

    // decompiled from Move bytecode v6
}

