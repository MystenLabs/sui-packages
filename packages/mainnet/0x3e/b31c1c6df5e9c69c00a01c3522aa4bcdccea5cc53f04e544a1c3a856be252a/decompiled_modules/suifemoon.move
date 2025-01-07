module 0x3eb31c1c6df5e9c69c00a01c3522aa4bcdccea5cc53f04e544a1c3a856be252a::suifemoon {
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

