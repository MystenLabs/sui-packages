module 0x6f17f8b64ab222fb2fcce4d5fc269212593152716e29eb5366bcc2f6c48e9860::whd {
    struct WHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHD>(arg0, 9, b"WHD", b"wahid", b"dedek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06eaead6-d9cc-4c07-9dda-62b8ec566656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

