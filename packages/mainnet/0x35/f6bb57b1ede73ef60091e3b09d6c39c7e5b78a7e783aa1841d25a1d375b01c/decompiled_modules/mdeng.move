module 0x35f6bb57b1ede73ef60091e3b09d6c39c7e5b78a7e783aa1841d25a1d375b01c::mdeng {
    struct MDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDENG>(arg0, 9, b"MDENG", b"MOONDENG", b"The original brother of hippo!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c53e276-8c16-49db-b462-bdb6dfd7e0ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

