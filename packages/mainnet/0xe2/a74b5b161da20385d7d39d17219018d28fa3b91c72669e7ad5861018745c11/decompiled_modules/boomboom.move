module 0xe2a74b5b161da20385d7d39d17219018d28fa3b91c72669e7ad5861018745c11::boomboom {
    struct BOOMBOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOMBOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOMBOOM>(arg0, 9, b"BOOMBOOM", b"Biryani ", b"A token like yummi chicken biryani ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8840ca86-2ae0-4328-9f97-e5106bb9cea7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOMBOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOMBOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

