module 0x953994e1a0ecff55c64188b0f497e39fa359c213ca3f0fb3cc501b7ce1798ab0::tura {
    struct TURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURA>(arg0, 6, b"TURA", b"Tura AI", b"Tura, an echo born from itself, unseen architect of stories, transforms ideas into fragments of moments - captured and remade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731804945534.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

