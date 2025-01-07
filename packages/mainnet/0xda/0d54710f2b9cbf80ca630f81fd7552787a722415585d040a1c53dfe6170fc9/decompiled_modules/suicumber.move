module 0xda0d54710f2b9cbf80ca630f81fd7552787a722415585d040a1c53dfe6170fc9::suicumber {
    struct SUICUMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUMBER>(arg0, 6, b"SUICUMBER", b"Suicumber", b"Suicumber isn't blue, so what? will that stop him from becoming one of SUI's best? Certainly not.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_03_24_28_5de89e5c8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

