module 0xfb34f08b5c6344b7d370936cec429cd25f71a26ed0e34c6fea3b64e0507a32ac::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"X Empire", x"5820456d706972652074686520667574757265206f662067616d650a0a486f6c642074696768742074686520667574757265206973206272696768740a0a68747470733a2f2f742e6d652f656d70697265780a68747470733a2f2f782e636f6d2f78656d7069726567616d650a68747470733a2f2f742e6d652f656d70697265626f743f70726f66696c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241111_001849_595_ce0604cf23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

