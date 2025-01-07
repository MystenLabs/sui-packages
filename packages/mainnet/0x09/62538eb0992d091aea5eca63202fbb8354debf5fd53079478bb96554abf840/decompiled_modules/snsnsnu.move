module 0x962538eb0992d091aea5eca63202fbb8354debf5fd53079478bb96554abf840::snsnsnu {
    struct SNSNSNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNSNSNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNSNSNU>(arg0, 9, b"SNSNSNU", b"Hdhs", b"Snsnsnamkaka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47e9fc44-d950-4ee0-b47f-a7c0137651a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNSNSNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNSNSNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

