module 0x2d230e010229682f2960353fc676eb38bbeec7ef813a78545baa2877b5e27bf5::boki {
    struct BOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKI>(arg0, 6, b"BOKI", b"Book of Kitty", b"We introduce the Book of Kitty ($BOKI), the perfect mashup of numerous mews in the meow-niverse, a meme money based on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cghk_Huaf_400x400_74978cf247.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

