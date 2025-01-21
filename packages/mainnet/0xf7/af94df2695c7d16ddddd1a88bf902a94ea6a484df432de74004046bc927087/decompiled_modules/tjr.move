module 0xf7af94df2695c7d16ddddd1a88bf902a94ea6a484df432de74004046bc927087::tjr {
    struct TJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJR>(arg0, 6, b"TJR", b"Official Trump Jr Meme", b"Following in the footsteps of my mother and father, towards a better future for America. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001236487_c5e56998d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

