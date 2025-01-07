module 0xbc2ccc72080abbb2a4bc94da5bf24a666b8940bcb285a6f284f6be4b16ef9cee::bale {
    struct BALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALE>(arg0, 6, b"BALE", b"BALELO MASCOT", x"42414c4c4f206973206d6f7265207468616e206a7573742061206469676974616c2063757272656e63792e20497420697320612073796d626f6c206f6620686f772074686520776f726c64206f66206d656d65732063616e206265207573656420636f6e7374727563746976656c7920746f2067656e657261746520706f73697469766520696d7061637420696e20636f6d6d756e69746965732e202442414c450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Xgs_Ugxa_Ho_Vt4_Yp_M_Wkq_PV_Fh1_Zi91huv_Ddu_PCDMR_Ezb_RW_e068348c71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

