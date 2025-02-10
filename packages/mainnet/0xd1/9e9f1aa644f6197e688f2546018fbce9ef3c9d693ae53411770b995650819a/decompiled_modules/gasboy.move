module 0xd19e9f1aa644f6197e688f2546018fbce9ef3c9d693ae53411770b995650819a::gasboy {
    struct GASBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GASBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GASBOY>(arg0, 6, b"GASBOY", b"Gasboy", b"The crypto revolution will not be televised... but it will be powered by $Gasboy . Join the movement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035486_3647858675.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GASBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GASBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

