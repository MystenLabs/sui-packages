module 0x5d7f56e62a89e54e026b3cd33132b962fc2c45bdbd3df203733ab12390e84381::sanin {
    struct SANIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIN>(arg0, 6, b"SANIN", b"SANIN ON SUI", x"546865206f6720736869622c20546865206661636520626568696e6420736869622e200a0a4d656d65733a2068747470733a2f2f742e6d652f53616e696e4d656d65730a5745423a20687474703a2f2f73616e696e2e7669700a58203a2068747470733a2f2f782e636f6d2f73616e696e6f6e657468", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3993_1d4fdb391d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

