module 0x16e24cc0975ff9b94335b08eb53e12184381bfa4997223547ec07a31bb5463d4::uy {
    struct UY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UY>(arg0, 9, b"UY", b"Outhouse ", b"I am going on the road ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5b6a9a7-e9e4-4c3f-87dc-093e36cf4569.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UY>>(v1);
    }

    // decompiled from Move bytecode v6
}

