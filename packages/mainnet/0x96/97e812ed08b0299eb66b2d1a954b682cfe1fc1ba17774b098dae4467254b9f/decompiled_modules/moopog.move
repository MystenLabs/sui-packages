module 0x9697e812ed08b0299eb66b2d1a954b682cfe1fc1ba17774b098dae4467254b9f::moopog {
    struct MOOPOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOPOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOPOG>(arg0, 6, b"MOOPOG", b"Moopog SUI", b"The older and more curious sister of Moo Deng.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DD_Dxd_Qi3_400x400_b4ff8d45a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOPOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOPOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

