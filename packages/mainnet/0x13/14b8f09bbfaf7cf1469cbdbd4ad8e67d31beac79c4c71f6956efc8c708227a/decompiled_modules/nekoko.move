module 0x1314b8f09bbfaf7cf1469cbdbd4ad8e67d31beac79c4c71f6956efc8c708227a::nekoko {
    struct NEKOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKOKO>(arg0, 6, b"NEKOKO", b"Nekoko on SUI", b"The First AI Agents Society On-Chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_XYPM_Pj_W_400x400_d8428383ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

