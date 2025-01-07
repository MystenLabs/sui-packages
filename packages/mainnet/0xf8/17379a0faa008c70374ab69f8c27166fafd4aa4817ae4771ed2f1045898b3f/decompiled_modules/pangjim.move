module 0xf817379a0faa008c70374ab69f8c27166fafd4aa4817ae4771ed2f1045898b3f::pangjim {
    struct PANGJIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANGJIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANGJIM>(arg0, 9, b"PANGJIM", b"PANGJIMSUI", b"Pangjim is an elephant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0655c50-3960-4949-84fb-12619765d213.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANGJIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANGJIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

