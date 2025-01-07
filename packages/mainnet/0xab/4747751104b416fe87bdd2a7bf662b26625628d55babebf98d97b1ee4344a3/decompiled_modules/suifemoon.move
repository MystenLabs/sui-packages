module 0xab4747751104b416fe87bdd2a7bf662b26625628d55babebf98d97b1ee4344a3::suifemoon {
    struct SUIFEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFEMOON>(arg0, 6, b"SUIFEMOON", b"SUIfeMOON", b"Remember SAFEMOON which went to billions on many chains? Now it's time to run again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifemoon_501808b3e1_c8af307900.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

