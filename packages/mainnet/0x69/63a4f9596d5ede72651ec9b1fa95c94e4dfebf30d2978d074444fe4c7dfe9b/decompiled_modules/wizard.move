module 0x6963a4f9596d5ede72651ec9b1fa95c94e4dfebf30d2978d074444fe4c7dfe9b::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"Wizard", b"Wizard Gang", x"4f6e65206f6620746865206d6f73742069636f6e69632073696e6773206f662061206c6567656e646172792077697a617264206973206120746f77657220746861742063616e277420626520656e7465726564206279206f7264696e617279206d65616e732e20497420657869737473206265747765656e206d6f6d656e7473206f72206f6e6c792061707065617273206174206365727461696e2074696d657320616e642069732066696c6c65642077697468206d6167696320746861742064656669657320756e6465727374616e64696e672e20546f20626520696e766974656420696e736964652069732061206f6e63652d696e2d612d6c69666574696d65206576656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Dkpe_Sfqc8_Ucsqgqs_M_Kim_B8qw7u_Dq_Ex_Am9_CMS_7_Mj_Kp_Q9_d7d369e108.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

