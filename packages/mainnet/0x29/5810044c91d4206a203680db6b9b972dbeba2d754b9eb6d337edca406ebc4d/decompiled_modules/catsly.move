module 0x295810044c91d4206a203680db6b9b972dbeba2d754b9eb6d337edca406ebc4d::catsly {
    struct CATSLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSLY>(arg0, 6, b"CATSLY", b"Catsly", b"Stranger than stranger things...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241222_010940_173_5adc5127ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

