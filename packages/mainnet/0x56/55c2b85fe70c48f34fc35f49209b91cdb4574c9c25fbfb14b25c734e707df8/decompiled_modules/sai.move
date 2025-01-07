module 0x5655c2b85fe70c48f34fc35f49209b91cdb4574c9c25fbfb14b25c734e707df8::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Starehu AI", b"The Most Powerful Physical AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Starehu_AI_01cb7e2016.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

