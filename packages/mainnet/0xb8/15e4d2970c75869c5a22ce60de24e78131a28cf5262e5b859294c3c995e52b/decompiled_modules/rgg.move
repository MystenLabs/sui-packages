module 0xb815e4d2970c75869c5a22ce60de24e78131a28cf5262e5b859294c3c995e52b::rgg {
    struct RGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGG>(arg0, 9, b"RGG", b"KFG", b"Oh well I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08a7441e-b201-44e8-85f3-2e87e39510cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

