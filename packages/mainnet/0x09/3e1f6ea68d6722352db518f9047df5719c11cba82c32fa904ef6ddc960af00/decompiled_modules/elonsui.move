module 0x93e1f6ea68d6722352db518f9047df5719c11cba82c32fa904ef6ddc960af00::elonsui {
    struct ELONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSUI>(arg0, 9, b"ELONSUI", b"ELON ON SUI", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQco2seX8pt51XSk-0oSAjBznIygqXZMLY61w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

