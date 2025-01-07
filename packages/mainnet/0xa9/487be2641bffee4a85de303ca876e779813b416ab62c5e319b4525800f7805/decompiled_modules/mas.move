module 0xa9487be2641bffee4a85de303ca876e779813b416ab62c5e319b4525800f7805::mas {
    struct MAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAS>(arg0, 9, b"MAS", b"masalam", b"anak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bedbdba2-cdf3-4320-97ee-00250b1dd78d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

