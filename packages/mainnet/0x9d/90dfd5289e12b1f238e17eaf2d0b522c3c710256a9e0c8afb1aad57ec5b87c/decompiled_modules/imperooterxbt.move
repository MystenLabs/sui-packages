module 0x9d90dfd5289e12b1f238e17eaf2d0b522c3c710256a9e0c8afb1aad57ec5b87c::imperooterxbt {
    struct IMPEROOTERXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMPEROOTERXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMPEROOTERXBT>(arg0, 9, b"SCOOTER", b"imperooterxbt", b"high lev pro trader, sometimes profesional comedic larp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1908297510256320512/ZfCHJgBE_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMPEROOTERXBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMPEROOTERXBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

