module 0x599c439b9f5391a312f4c4c1b2da102af3fa9b90106de3a24fef927b6d7f7014::cartel {
    struct CARTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTEL>(arg0, 6, b"CARTEL", b"CARTEL on SUI", b"Pepe the Hutt Cartel | The galaxys most wanted token   Star Wars Inspired Meme EMPIRE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mj_Gd_7nh_400x400_c8b07073d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

