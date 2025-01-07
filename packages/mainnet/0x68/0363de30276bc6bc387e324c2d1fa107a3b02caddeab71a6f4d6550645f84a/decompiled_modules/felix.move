module 0x680363de30276bc6bc387e324c2d1fa107a3b02caddeab71a6f4d6550645f84a::felix {
    struct FELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELIX>(arg0, 6, b"FELIX", b"Felix the Cat", b"Felix was the first fully realized recurring animal character in the history of American film animation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732075722938.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

