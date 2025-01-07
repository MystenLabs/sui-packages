module 0xc80c4ed0cb975dced0f8472f98c6d1c8d5a08d908a6903419d872358a0596b08::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 9, b"SUPA", b"Extremely cool", b"SUPAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIGeB1eu44c6-3S27G-GOZX_cG0-EdVKRiFZDZHbD-52m3XzJibvrY9DxZ2YoaSbyXtzU&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

