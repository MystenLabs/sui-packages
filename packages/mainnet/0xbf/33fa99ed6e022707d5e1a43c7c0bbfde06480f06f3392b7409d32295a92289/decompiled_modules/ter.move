module 0xbf33fa99ed6e022707d5e1a43c7c0bbfde06480f06f3392b7409d32295a92289::ter {
    struct TER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TER>(arg0, 9, b"TER", b"TERRIBLE", b"terrible amazing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00ccb78c-7e74-4af7-9bd0-8ea4dec40abb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TER>>(v1);
    }

    // decompiled from Move bytecode v6
}

