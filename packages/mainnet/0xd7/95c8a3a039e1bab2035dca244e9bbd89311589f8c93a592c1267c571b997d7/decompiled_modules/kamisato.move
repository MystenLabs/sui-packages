module 0xd795c8a3a039e1bab2035dca244e9bbd89311589f8c93a592c1267c571b997d7::kamisato {
    struct KAMISATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMISATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMISATO>(arg0, 9, b"KAMISATO", b"Ayayo", b"Kamisato ayayo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/072e6fd6-435e-4a8b-be81-c97d51ff2c95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMISATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMISATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

