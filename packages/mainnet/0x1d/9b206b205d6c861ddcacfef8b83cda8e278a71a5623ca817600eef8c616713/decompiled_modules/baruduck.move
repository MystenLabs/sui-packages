module 0x1d9b206b205d6c861ddcacfef8b83cda8e278a71a5623ca817600eef8c616713::baruduck {
    struct BARUDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARUDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARUDUCK>(arg0, 6, b"BARUDUCK", b"Baru Duck", x"42415255204455434b2024424152554455434b20697320746865206375746573740a616e642066756e6e69657374206d656d65636f696e206f6e20746865205355490a6e6574776f726b2c206272696e67696e672066756e20616e6420656e7465727461696e6d656e740a746f207468652063727970746f20776f726c642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_04_A_s_13_41_39_8daf1c71_23c3c5f206.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARUDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARUDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

