module 0x889762e3bbba1437d072e67551ebe2d16a32ed2b27b50c221e194d319b387928::xmars {
    struct XMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMARS>(arg0, 0, b"XMARS", b"XMARS", b"XMARS is a leading cryptocurrency known for its security and adaptability. Powered by advanced blockchain technology, XMARS ensures rapid transactions and robust security measures, making it ideal for global use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/levutrieu/X-MARS/main/icon/xmars-01.ico")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMARS>>(v1);
        0x2::coin::mint_and_transfer<XMARS>(&mut v2, 47000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMARS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

