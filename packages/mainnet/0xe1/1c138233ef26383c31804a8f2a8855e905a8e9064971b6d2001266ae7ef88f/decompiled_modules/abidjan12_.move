module 0xe11c138233ef26383c31804a8f2a8855e905a8e9064971b6d2001266ae7ef88f::abidjan12_ {
    struct ABIDJAN12_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABIDJAN12_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABIDJAN12_>(arg0, 9, b"ABIDJAN12_", b"Jima", x"5765206c6f766520736f206d75636820776577652068657920746f20746865207465616d207765206c6f766520796f7520616e6420616c6c2074686520737563636573732049e280996d2066726f6d2049766f727920436f61737420f09f87a8f09f87ae20616c6c2074686520737570706f7274206c65742067657420746865206d6f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/373a3699-9d4c-4f2b-90f8-a7fadf2eaf0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABIDJAN12_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABIDJAN12_>>(v1);
    }

    // decompiled from Move bytecode v6
}

