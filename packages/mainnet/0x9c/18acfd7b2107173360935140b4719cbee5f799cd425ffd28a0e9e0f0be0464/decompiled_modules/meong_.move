module 0x9c18acfd7b2107173360935140b4719cbee5f799cd425ffd28a0e9e0f0be0464::meong_ {
    struct MEONG_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEONG_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEONG_>(arg0, 9, b"MEONG_", b"Meong", b"Cutest Meong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73166d92-8fac-4284-9aca-a9b846b917da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEONG_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEONG_>>(v1);
    }

    // decompiled from Move bytecode v6
}

