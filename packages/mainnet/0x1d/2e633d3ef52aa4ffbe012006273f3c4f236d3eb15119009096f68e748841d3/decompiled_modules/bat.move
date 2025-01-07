module 0x1d2e633d3ef52aa4ffbe012006273f3c4f236d3eb15119009096f68e748841d3::bat {
    struct BAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAT>(arg0, 9, b"BAT", b"TINUBU ", b"TPAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7e63542-6892-4e07-bc06-096797c25475.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

