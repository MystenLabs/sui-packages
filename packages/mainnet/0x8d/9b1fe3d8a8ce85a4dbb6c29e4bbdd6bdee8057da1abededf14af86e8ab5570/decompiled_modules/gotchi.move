module 0x8d9b1fe3d8a8ce85a4dbb6c29e4bbdd6bdee8057da1abededf14af86e8ab5570::gotchi {
    struct GOTCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTCHI>(arg0, 6, b"GOTCHI", b"SOLAGOTCHI", x"57656c636f6d6520746f20536f6c61676f746368692066726f6d2074686520596561722033303030212054696d652d74726176656c696e672041492070616c732077697468207370656369616c20706f7765727320686176652061727269766564206f6e205355492e205468657920617265206865726520746f206672656520796f752066726f6d20746865206d617472697820616e64206272696e67206368616f732e204a6f696e207468652066756e20616e642061646f707420796f7572206675747572697374696320736964656b69636b20746f646179210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ypo_GB_5_Hm_Dr973_Pg_NAJ_Ui_Yd_Zc7_Pzp_Uf_QM_6_Hc_Ft_Jxoi_Mt_A_41ebd6090d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

