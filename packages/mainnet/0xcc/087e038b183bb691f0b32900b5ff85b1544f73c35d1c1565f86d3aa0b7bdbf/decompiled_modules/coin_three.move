module 0xcc087e038b183bb691f0b32900b5ff85b1544f73c35d1c1565f86d3aa0b7bdbf::coin_three {
    struct COIN_THREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_THREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_THREE>(arg0, 9, b"cointhree", b"coin three", b"coin three description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/fd73123f-9c14-474e-8953-f30111635198.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_THREE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_THREE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

