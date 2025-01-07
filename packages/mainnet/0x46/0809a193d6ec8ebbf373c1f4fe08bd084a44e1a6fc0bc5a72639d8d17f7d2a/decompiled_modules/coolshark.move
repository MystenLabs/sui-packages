module 0x460809a193d6ec8ebbf373c1f4fe08bd084a44e1a6fc0bc5a72639d8d17f7d2a::coolshark {
    struct COOLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLSHARK>(arg0, 6, b"COOLSHARK", b"Cool Shark wif AK", b"Cool Shark wif AK runs the Sui with no apologies. Armed and dangerous, this shark isnt here to swim, hes here to dominate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_cartoon_design_of_ashark_with_sunglasses_firing_an_ak_fea34dd3_77fd_4d64_9219_4a63184a0dc0_1_9c1af04fa4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

