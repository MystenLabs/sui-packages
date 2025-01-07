module 0x5d8937ea5a6543498c8d439690ef117efcfe865706c837c799ad705635ef58d3::oco {
    struct OCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCO>(arg0, 9, b"OcO", b"OceanicOracle", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9tStSQdYKgA5UZTiNLgZahq_xJgC7WM3DVnIIqaJqDvqPExOwnLqulBuhvYPlaVnUxls&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

