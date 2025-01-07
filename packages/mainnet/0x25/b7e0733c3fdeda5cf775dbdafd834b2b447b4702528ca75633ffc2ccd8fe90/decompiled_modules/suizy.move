module 0x25b7e0733c3fdeda5cf775dbdafd834b2b447b4702528ca75633ffc2ccd8fe90::suizy {
    struct SUIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZY>(arg0, 9, b"SUIZY", b"SuizyOnSui", x"5375693a2054686520667574757265206f6620626c6f636b636861696e2e202020202020202020202020202020202020202020202020202020202020200a5355495a593a2054686520756e6f6666696369616c206d6173636f742c206272696e67696e672066756e20746f20746865206675747572652e20284e6f2c20736572696f75736c7929", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccde220f-eee7-4914-8d02-ea1c693ec41d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

