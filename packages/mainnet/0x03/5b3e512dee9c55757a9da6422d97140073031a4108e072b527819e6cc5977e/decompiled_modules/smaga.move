module 0x35b3e512dee9c55757a9da6422d97140073031a4108e072b527819e6cc5977e::smaga {
    struct SMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGA>(arg0, 6, b"SMAGA", b"Super MAGA", b"47th President of the United States of America, taking on villains like Kamala to Make America Great Again. Suiper MAGA is unstoppable. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_04_23_30_49_39416eaaac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

