module 0x6e34818365ee861ae31293579aa2fefb590b1e1f07536ca6273b5debdcf386ad::wseal {
    struct WSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSEAL>(arg0, 6, b"wSeal", b"Wrapped Seal", b"Wrapped Seal is the mysterious guardian of the frozen seas, always wrapped in its magical cloak to protect the ocean's secrets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasd12312543_7cc82aa4a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

