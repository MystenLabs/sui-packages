module 0x71fc61d2ac805c5a92487e118ddb21c5f4e8827bc3c083a3c05beb7e342376e2::sity {
    struct SITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITY>(arg0, 6, b"SITY", b"Sui City", b"Sui City is an AI hyper-realistic metaverse based on oncyber, in which the avatar is not only the body in the metaverse but another you in the parallel world of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737743473433.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

