module 0x25894a384dca15abb2c4c0efacca561ae324ce734731c50d8c3285680f5bb108::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 6, b"BAB", b"Boom And Bust", b"Boom And bust cycle repeats!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmci_B88_H3fkioi2guuw5_X_Xb_X_Yf_YVE_61_Szx6y_Vnb_U4i_Go_YK_796850eadb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

