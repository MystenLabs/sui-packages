module 0x78749a6f44f9716a9921d5d0528c35d57a809667cde6035650f141975ad5ed42::elie {
    struct ELIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIE>(arg0, 9, b"ELIE", b"Ocean EEL", b"The Cutest Creature in Ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/969bdd8b-1562-4e37-85d7-31d81806ee85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

