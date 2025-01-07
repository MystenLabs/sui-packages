module 0x1298855214afcc991944e59ec6f07a900c3e0ba370715f347a4197c9b72a7485::ctoonpopdeng {
    struct CTOONPOPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOONPOPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOONPOPDENG>(arg0, 6, b"CTOONPOPDENG", b"0x6ac3b6012ce49c66c90ddc1ed6f2e37b0a56e1d3b668c10e9b288aec85837eb2::popd::POPD", b"CTO ON POPDENG LINK IN BIO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POOOPDE_Ng_6cb3bbcb9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOONPOPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTOONPOPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

