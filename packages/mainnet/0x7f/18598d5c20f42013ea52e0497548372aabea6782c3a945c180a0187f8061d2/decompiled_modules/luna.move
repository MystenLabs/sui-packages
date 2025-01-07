module 0x7f18598d5c20f42013ea52e0497548372aabea6782c3a945c180a0187f8061d2::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"LU NA sui", b"Luna On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.pixabay.com/photo/2022/02/18/16/09/ape-7020995_1280.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUNA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

