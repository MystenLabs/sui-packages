module 0x30bd14fba73b0c8bf457dbd3e4989254c823bae49428557b70d81a1327339cd6::pkin {
    struct PKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKIN>(arg0, 6, b"Pkin", b"Pumpkin", b"1st Halloween AI Pumpkin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_c7e7ae0f66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

