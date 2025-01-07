module 0xb4d43b64c69d279731b01cda26232ccecf39236cd05024a22c5bc6b9d0c84503::cduck {
    struct CDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDUCK>(arg0, 6, b"CDUCK", b"Crown Duck", x"54686973206475636b20697320746865206b696e67206f662063616c6d20696e207468652063727970746f776f726c642e204e6f7468696e672063616e206469737475726220686973206368696c696e672e200a4a7573742072656c617820616e6420656e6a6f792074686520666c696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_09_08_214740_d22fd2a43d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

