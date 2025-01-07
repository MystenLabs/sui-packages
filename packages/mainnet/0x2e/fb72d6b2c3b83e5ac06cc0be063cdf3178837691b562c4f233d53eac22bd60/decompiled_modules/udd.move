module 0x2efb72d6b2c3b83e5ac06cc0be063cdf3178837691b562c4f233d53eac22bd60::udd {
    struct UDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDD>(arg0, 9, b"UDD", b"Si", b"Msk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d74d8c3c-cce4-47c5-86f9-7c082f4d012d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

