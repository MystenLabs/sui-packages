module 0x2e645ae496617fac0c3c442dbc7e75a5ee349f354ed59df0b0871315f118bf37::petom {
    struct PETOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETOM>(arg0, 9, b"PETOM", b"Pepe tomato", b"This meme was created in honor of tomato season. Soon we'll be picking fruit in the SUI ecosystem like these tomatoes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c1da4c68fa5abd8b2981a136bec3b2cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

