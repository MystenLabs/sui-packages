module 0x219e200db1ed976f66289c9852ae27c170c6337b08a2514b2c0edc5b79225677::suixin {
    struct SUIXIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXIN>(arg0, 6, b"SUIXIN", b"Suixin the asian fish", b"Your favourite sui creature on the SUI SEA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_19_94548dcc58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

