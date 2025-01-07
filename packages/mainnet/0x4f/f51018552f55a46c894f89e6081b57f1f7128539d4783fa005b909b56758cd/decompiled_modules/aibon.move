module 0x4ff51018552f55a46c894f89e6081b57f1f7128539d4783fa005b909b56758cd::aibon {
    struct AIBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBON>(arg0, 9, b"AIBON", b"Lem Aibon", b"It's just a glue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48350eb5-40c1-47fd-8b57-1361614e508c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIBON>>(v1);
    }

    // decompiled from Move bytecode v6
}

