module 0x72b4aa4fc94f22569daf9aea605f5293f292b994575e218d624ff09b4a09a6da::mgga {
    struct MGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGGA>(arg0, 6, b"MGGA", b"MAGA THE GOAT", x"4a6f696e204d4147412074686520476f617420696e2061205955474520746f6b656e210a446566656174205a6f6d62696563726174732c20647261696e207468650a7377616d7020616e642073686f6f74204b616d616c61277320636c616e212043616e20796f750a68616e646c652069743f2046696c6c20746865206261677320616e64206a6f696e0a7468697320616476656e7475726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_56_0d93a4f918.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

