module 0xda874fc58056f8d548767a22c94dfdbe8fa734d6354714c2f84ec6fb67b9c811::zachxbt {
    struct ZACHXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACHXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACHXBT>(arg0, 6, b"ZACHXBT", b"Zachxbt", b"Justice for Zachxbt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028309_289582406d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACHXBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZACHXBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

