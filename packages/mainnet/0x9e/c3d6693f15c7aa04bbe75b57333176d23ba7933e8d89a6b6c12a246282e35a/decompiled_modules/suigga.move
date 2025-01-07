module 0x9ec3d6693f15c7aa04bbe75b57333176d23ba7933e8d89a6b6c12a246282e35a::suigga {
    struct SUIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGA>(arg0, 6, b"SUIGGA", b"suigga", b"suigga takeover the chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suigga_257f2572ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

