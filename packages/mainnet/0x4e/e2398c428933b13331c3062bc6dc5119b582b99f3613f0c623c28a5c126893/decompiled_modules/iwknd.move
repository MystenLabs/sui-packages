module 0x4ee2398c428933b13331c3062bc6dc5119b582b99f3613f0c623c28a5c126893::iwknd {
    struct IWKND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWKND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWKND>(arg0, 9, b"IWKND", b"hensn", b"jdjdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a914934-a17b-45e6-9017-fcf43d085a96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWKND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWKND>>(v1);
    }

    // decompiled from Move bytecode v6
}

