module 0x4801ddb7feaf55a0ebd05427dc394c0ff1543d1337d37d88723dc8d86c19d297::aonie {
    struct AONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AONIE>(arg0, 6, b"AONIE", b"AonieOnSui", b"$AONIE IS THE CUTEST ANIMAL ON SUI, ON A MISSION TO BE THE GREATEST DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001235_a176fab188.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

