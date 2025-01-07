module 0x53b39e13d61372fdc1cb9b4435ebb6fbedb69a47232461560f812eabaa0d06cb::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 9, b"SN", b"Tenants ", b"Cjc is a great player but he is ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd180221-466e-4229-a9cf-997106827e86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SN>>(v1);
    }

    // decompiled from Move bytecode v6
}

