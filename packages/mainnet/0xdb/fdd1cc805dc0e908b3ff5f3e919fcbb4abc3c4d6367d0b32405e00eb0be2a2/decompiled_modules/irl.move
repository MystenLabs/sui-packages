module 0xdbfdd1cc805dc0e908b3ff5f3e919fcbb4abc3c4d6367d0b32405e00eb0be2a2::irl {
    struct IRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRL>(arg0, 6, b"IRL", b"IRL on SUI", b"Hello, kittens. How you doing?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_FD_c2_Kk_400x400_874b8f4d24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

