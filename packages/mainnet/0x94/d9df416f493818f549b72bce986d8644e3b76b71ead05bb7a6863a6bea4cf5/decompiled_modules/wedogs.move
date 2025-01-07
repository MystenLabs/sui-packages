module 0x94d9df416f493818f549b72bce986d8644e3b76b71ead05bb7a6863a6bea4cf5::wedogs {
    struct WEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGS>(arg0, 9, b"WEDOGS", b"Dog's", b"Lets do fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/caa595a8-b03f-4b5d-a685-8dc2294598b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

