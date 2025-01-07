module 0xcca3253d8a6de7a051795a96b0fa5ecc12a779458e1b6365f90165951ea27aa3::bbpk {
    struct BBPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBPK>(arg0, 6, b"BBPK", b"Blue Penguin Pack", b" $BBPK is on a moon mission!  Our penguins got the bag, the rockets fueled, and were heading straight for the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019966_efa79138f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

