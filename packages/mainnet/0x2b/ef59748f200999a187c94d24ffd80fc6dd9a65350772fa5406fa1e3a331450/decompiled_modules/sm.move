module 0x2bef59748f200999a187c94d24ffd80fc6dd9a65350772fa5406fa1e3a331450::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 9, b"SM", b"SuiMumi", b"Sui Pepe Mumui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97851f62-fde8-4393-aa0b-08bd33c3ea6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SM>>(v1);
    }

    // decompiled from Move bytecode v6
}

