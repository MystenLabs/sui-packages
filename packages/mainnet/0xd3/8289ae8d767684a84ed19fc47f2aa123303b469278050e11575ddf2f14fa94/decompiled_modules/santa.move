module 0xd38289ae8d767684a84ed19fc47f2aa123303b469278050e11575ddf2f14fa94::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"Santa", b"Floki Santa", x"466c6f6b692053616e74610a0a447265616d2c2042656c6965766520616e64204669676874210a0a466c6f6b6953616e746120776173206372656174656420746f206d616b6520686973746f7279206174204368726973746d6173212043616e207765206368616e6765206f7572206c69766573206265666f726520776520656e74657220746865206e657720796561723f205965732c20736f20647265616d2c2062656c6965766520616e64206669676874207769746820466c6f6b6953616e746121204c6173742079656172204154482033382e35580a3a20466c6f6b6953616e74612e6e6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006238_a23f644076.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

