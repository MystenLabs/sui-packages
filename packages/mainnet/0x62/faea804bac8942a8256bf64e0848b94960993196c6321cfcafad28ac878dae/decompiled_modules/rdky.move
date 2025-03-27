module 0x62faea804bac8942a8256bf64e0848b94960993196c6321cfcafad28ac878dae::rdky {
    struct RDKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDKY>(arg0, 6, b"RDKY", b"$REDKY", b"A crypto monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0403_df5af6f9b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

