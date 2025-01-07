module 0x5346aabc8c14d969408e7a27a1ac070b8953a42b0676651e437cfdf9f0cec0c5::kimjongsui {
    struct KIMJONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMJONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMJONGSUI>(arg0, 6, b"KIMJONGSUI", b"Kim Jong sui", b"the infamous ruler of North Korea, has discovered the SUI Chain  and, of course, he wants full control! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031058_a9270e6a16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMJONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMJONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

