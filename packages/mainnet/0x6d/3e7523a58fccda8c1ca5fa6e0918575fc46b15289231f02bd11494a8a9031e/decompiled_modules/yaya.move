module 0x6d3e7523a58fccda8c1ca5fa6e0918575fc46b15289231f02bd11494a8a9031e::yaya {
    struct YAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAYA>(arg0, 6, b"YAYA", b"YAYA THE BABYDUCK", b"YaYa the BabyDuck  launching on Moonshot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cc1zy_Izp_400x400_f4cb6a8be7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

