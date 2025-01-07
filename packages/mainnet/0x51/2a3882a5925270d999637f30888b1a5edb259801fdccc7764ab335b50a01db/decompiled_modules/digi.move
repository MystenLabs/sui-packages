module 0x512a3882a5925270d999637f30888b1a5edb259801fdccc7764ab335b50a01db::digi {
    struct DIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGI>(arg0, 9, b"DIGI", b"Digi kong", b"Digikong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e963ff0e-9cdf-43af-908a-c7adde8e221a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

