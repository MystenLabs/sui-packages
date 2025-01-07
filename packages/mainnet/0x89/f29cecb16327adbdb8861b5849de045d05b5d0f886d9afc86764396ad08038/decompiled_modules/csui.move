module 0x89f29cecb16327adbdb8861b5849de045d05b5d0f886d9afc86764396ad08038::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 9, b"CSUI", b"Catssui", b"Buy and hold for long term", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ecdc5b5-de57-414b-8346-8ec3b45e5832.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

