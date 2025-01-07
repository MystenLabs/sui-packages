module 0xbbd87e7999ede7912bb503e405a8c32e110a9dbe2cca067f65bd75c69bcca471::iceking {
    struct ICEKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEKING>(arg0, 6, b"ICEKING", b"Sui Ice King", b"Ice King is the new king of the sea, Straight from the icy peaks of Ooo, Ice King is taking over the market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_235316_536_e51f255708.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

