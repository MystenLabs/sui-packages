module 0x549a48ba90cb64040ff27a8da6db94400ffcd6304752fd6e87e344c6274b7004::moutai1 {
    struct MOUTAI1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUTAI1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUTAI1>(arg0, 6, b"MOUTAI1", b"MOUTAI", b"111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Io_C3ao_400x400_8daec7a918.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUTAI1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUTAI1>>(v1);
    }

    // decompiled from Move bytecode v6
}

