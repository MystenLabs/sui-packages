module 0x7ee87247ba1f5d2901f243bb3399979c66364f4b714c19e059efdf10c7c7d3e8::ruk {
    struct RUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUK>(arg0, 9, b"RUK", b"Rukayya", b"Ruktoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6f53e12-36ec-4745-8597-0d935ddee32a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

