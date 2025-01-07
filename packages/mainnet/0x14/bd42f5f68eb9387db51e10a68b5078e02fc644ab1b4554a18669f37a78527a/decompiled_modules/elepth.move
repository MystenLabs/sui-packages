module 0x14bd42f5f68eb9387db51e10a68b5078e02fc644ab1b4554a18669f37a78527a::elepth {
    struct ELEPTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPTH>(arg0, 6, b"Elepth", b"Elepth Sui", b"Elepth Launching on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq71t25ZtzFlPkK_l6bDczeZEn_yOs8i9-YQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELEPTH>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPTH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

