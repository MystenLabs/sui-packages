module 0x975c823f07cfa32892fbd284b8d0ccac8bdc8a7226c77c2232682444e67d4f3b::pums {
    struct PUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMS>(arg0, 6, b"PUMS", b"Pump On SUI", b"The trainer behind the rise of every pumping dog and cat meme. Built on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Vhm_RE_Ia_400x400_d42b7d1e12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

