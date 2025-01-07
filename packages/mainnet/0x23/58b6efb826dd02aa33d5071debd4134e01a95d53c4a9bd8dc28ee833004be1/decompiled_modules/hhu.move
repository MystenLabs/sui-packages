module 0x2358b6efb826dd02aa33d5071debd4134e01a95d53c4a9bd8dc28ee833004be1::hhu {
    struct HHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHU>(arg0, 9, b"HHU", b"Huhua", b"Token huhua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c364e77-7b2e-4742-8461-32c53fc50d56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

