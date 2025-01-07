module 0xddbdc2f7b053d76b717c50d7832dfff4610bc7d90de457e643902587cbbf29da::hitoken_do {
    struct HITOKEN_DO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITOKEN_DO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITOKEN_DO>(arg0, 9, b"HITOKEN_DO", b"Hitoken", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f1e2941-89be-4897-9343-c66614ed1882.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITOKEN_DO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITOKEN_DO>>(v1);
    }

    // decompiled from Move bytecode v6
}

