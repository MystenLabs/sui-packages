module 0x18dde4b687ffeabbf1b2fde750197d58d73a342e9c01d59122f865c34cff48f3::cpc {
    struct CPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPC>(arg0, 9, b"CPC", b"CUPCAKE", b"cake was too much so cupcakes are better for birthdays.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/443cc65d-2f27-4354-851d-c3a52e6f2775.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

