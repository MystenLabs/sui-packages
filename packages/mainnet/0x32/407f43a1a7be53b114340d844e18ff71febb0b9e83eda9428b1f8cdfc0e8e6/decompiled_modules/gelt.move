module 0x32407f43a1a7be53b114340d844e18ff71febb0b9e83eda9428b1f8cdfc0e8e6::gelt {
    struct GELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GELT>(arg0, 6, b"GELT", b"Gelt", x"48616e756b6b6168202447454c542061726520746f6b656e7320676976656e20647572696e6720746865204a657769736820666573746976616c206f662048616e756b6b61682e204f6e6c7920636f696e7320746f2067616d626c6521204c657427732070756d7020377820666f722074686520372064617973206f662048616e756b6b61682120546f6b656e7320617265207573656420746f2067616d626c65207769746820746865204472656964656c2e20506c61792053414655210a0a2a4472656964656c206e6f7420696e636c756465640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734788914290.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GELT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GELT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

