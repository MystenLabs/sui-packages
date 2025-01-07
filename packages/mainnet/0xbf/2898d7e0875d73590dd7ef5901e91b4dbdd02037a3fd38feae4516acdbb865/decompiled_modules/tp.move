module 0xbf2898d7e0875d73590dd7ef5901e91b4dbdd02037a3fd38feae4516acdbb865::tp {
    struct TP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TP>(arg0, 9, b"TP", b"Trio", b"Low cost transfer ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdceece2-96b1-4af0-9ef4-a631b71b179c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TP>>(v1);
    }

    // decompiled from Move bytecode v6
}

