module 0x55a4184fe13d2a6e060ec76e72087db3064e1092b3d4c3ccc1125d3960e5c035::looney1 {
    struct LOONEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOONEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOONEY1>(arg0, 6, b"Looney1", b"Looney", b"The Looniest Crypto on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c109865d_9508_4683_a9ed_848c6a00979e_b935704497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOONEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOONEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

