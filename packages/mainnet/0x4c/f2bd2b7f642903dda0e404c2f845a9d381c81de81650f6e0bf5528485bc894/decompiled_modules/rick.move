module 0x4cf2bd2b7f642903dda0e404c2f845a9d381c81de81650f6e0bf5528485bc894::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 9, b"RICK", b"Rick coin", b"Rick c-137", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/928bd353-b49b-4f20-91d8-5740a48621b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

