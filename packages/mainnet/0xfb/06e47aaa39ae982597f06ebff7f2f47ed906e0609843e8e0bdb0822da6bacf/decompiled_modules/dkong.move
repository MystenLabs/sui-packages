module 0xfb06e47aaa39ae982597f06ebff7f2f47ed906e0609843e8e0bdb0822da6bacf::dkong {
    struct DKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKONG>(arg0, 6, b"DKONG", b"DONKEY KONG", x"24444b4f4e4720e2809320446f6e6b6579204b6f6e6720536d617368657320496e746f205375692120f09fa68df09f92a50a5468652077696c646573742c62616e616e612d6675656c6564206d656d6520636f696e206861732061727269766564206f6e20537569212024444b4f4e472069736ee2809974206a75737420616e6f7468657220746f6b656ee280946974e280997320612066756c6c2d626c6f776e206d656d65207265766f6c7574696f6e2c20636f6d62696e696e672074686520756e73746f707061626c6520656e65726779206f6620446f6e6b6579204b6f6e6720776974682074686520737065656420616e6420706f776572206f662074686520537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747526504322.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

