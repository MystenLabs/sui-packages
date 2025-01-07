module 0x3d6e14f29b3b28314a2bb7140b9fb83e342db6e5769b40d74ab9ac612cf289c3::suiwin98 {
    struct SUIWIN98 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIN98, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIN98>(arg0, 9, b"SUIWIN98", b"Windows98", b"Rarity for windows 98", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7216a2d2-93dd-4f47-869b-3cb0fc7fddbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIN98>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWIN98>>(v1);
    }

    // decompiled from Move bytecode v6
}

