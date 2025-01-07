module 0xc23f290a22522dafe71c8775a7e05dec2b3e94103629ef4f0c1640f1867b7eaf::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 9, b"LUFFY", b"Monkey D. Luffy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/76/da/03/76da03c579566626fa270bdb6df1280b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUFFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

