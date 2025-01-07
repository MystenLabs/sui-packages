module 0x849e856cf58c5ac0d552bff8ae6e1cdc430592fd161ea05f54cc282975240577::jg {
    struct JG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JG>(arg0, 9, b"JG", b"XC", b"VB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/683cc85b-4a02-410e-a17f-8ca6d08e302f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JG>>(v1);
    }

    // decompiled from Move bytecode v6
}

