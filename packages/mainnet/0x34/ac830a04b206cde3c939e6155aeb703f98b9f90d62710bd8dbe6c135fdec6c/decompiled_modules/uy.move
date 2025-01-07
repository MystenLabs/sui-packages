module 0x34ac830a04b206cde3c939e6155aeb703f98b9f90d62710bd8dbe6c135fdec6c::uy {
    struct UY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UY>(arg0, 9, b"UY", b"Outhouse ", b"I am going on the road ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41878477-e450-4747-8e16-9bd4fc4c5436.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UY>>(v1);
    }

    // decompiled from Move bytecode v6
}

