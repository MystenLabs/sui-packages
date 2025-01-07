module 0xfd1d5e6c4052adbc7e4edc63e907ae1a24e47cbb9d55d3932adf9ca7797ff777::pepemas {
    struct PEPEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMAS>(arg0, 6, b"PEPEMAS", b"Pepemas", x"24504550454d41532069732074686520666573746976652050657065206d656d65636f696e20686f7070696e6720696e746f2074686520686f6c6964617920736561736f6e2e204465636b6564206f757420696e2053616e7461206861747320616e64207772617070656420696e207175657374696f6e61626c652066696e616e6369616c206465636973696f6e732c207468697320746f6b656e20697320666f7220646567656e7320647265616d696e67206f662061204368726973746d6173206d697261636c65e280946c696b6520612066726f67207475726e696e6720696e746f2061204c616d626f2e20f09f90b8f09f8e852e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734054859210.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

