module 0x8574d40b514484fc22f268bb7d94d3290224349f92753511a494f4d17a7c13d8::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Sushi Service of Sui", b"$SUISHI is the delectable token inspired by sushi, now rolling out on Sui. With the Sushi service of Sui, you're in for a treat that blends taste and technology. Dive into the delicious world of $SUISHI and enjoy a feast of Sui possibilities!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISHI_e7013c83c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

