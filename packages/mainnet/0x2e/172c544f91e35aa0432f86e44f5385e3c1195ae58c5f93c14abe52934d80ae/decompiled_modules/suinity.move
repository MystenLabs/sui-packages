module 0x2e172c544f91e35aa0432f86e44f5385e3c1195ae58c5f93c14abe52934d80ae::suinity {
    struct SUINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINITY>(arg0, 9, b"SUINITY", b"Suinity girl", b"Suinity is Sui's ecosystem mascot girl with the diamond heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/17007766/file/original-b8df08462c592752ec01ed8774dbf7e7.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINITY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINITY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

