module 0x9095f68f08ed75e4bbb44a3dccd7a98436081e852e82840e4481342ac0ee5ac6::clevo {
    struct CLEVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLEVO>(arg0, 6, b"CLEVO", b"Sui Clevo", b"CLEVO is a cute pig, ready to make a big splash at the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009417_c3502f3fa5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLEVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

