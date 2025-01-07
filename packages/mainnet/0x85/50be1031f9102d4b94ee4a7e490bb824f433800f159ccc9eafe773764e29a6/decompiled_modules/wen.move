module 0x8550be1031f9102d4b94ee4a7e490bb824f433800f159ccc9eafe773764e29a6::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 6, b"WEN", b"WEN SUI", b"Immortalizing wen culture with the cutest cat in web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_F_Gf_Gn_RC_400x400_1_16ab2b8683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

