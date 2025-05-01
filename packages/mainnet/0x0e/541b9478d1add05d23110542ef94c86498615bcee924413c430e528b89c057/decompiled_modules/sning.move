module 0xe541b9478d1add05d23110542ef94c86498615bcee924413c430e528b89c057::sning {
    struct SNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNING>(arg0, 6, b"SNING", b"SUINNING", b"You may even get tired of SUINNING!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINNING_025e9f49f4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

