module 0xf7160fa7116c2d50f499841ce820ca4b050421d962329ac2f5a2cb4daf421f75::madrid {
    struct MADRID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADRID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADRID>(arg0, 9, b"MADRID", b"Madrid Sui", b"Madrid on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5a62766-1fda-495d-a1ff-de5843f35c64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADRID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADRID>>(v1);
    }

    // decompiled from Move bytecode v6
}

