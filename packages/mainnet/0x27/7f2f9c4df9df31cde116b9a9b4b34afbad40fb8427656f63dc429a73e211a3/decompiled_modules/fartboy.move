module 0x277f2f9c4df9df31cde116b9a9b4b34afbad40fb8427656f63dc429a73e211a3::fartboy {
    struct FARTBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTBOY>(arg0, 6, b"FARTBOY", b"FARTBOY OG", x"746865206f726967696e616c206661727420626f79206b656570732067657474696e67206661726d65642c20736f20746865206e65772063746f207465616d206465636964657320746f206c61756e63682061206e65772046415254424f5920616e64206275696c642061207361666520737061636520776974682074686520636f6d6d756e6974792074616767696e6720616c6f6e6720616e642070757368207769746820746865206d772066756e6473206d6164652066726f6d2074686520636f6d6d756e697479206d656d6265727320696e636c7564696e6720706572736f6e616c2066756e647321204974277320676f6e6e612073656e6420686172640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tvdga_Ba_Fu1_HM_Ex5_Lfuv7_Ai_H5rz_Q21_PMET_Ae2w_Vazudu_T_1c59bbca3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

