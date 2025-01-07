module 0xfa98f5b15cb50a902de1f32cf5dc1b4850b9991f48fdbd69f7a19bc02ef19590::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"BILL", b"BILL THE BEAR", x"42696c6c20697320796f7572206661766f7269746520696e7465726e6574206265737469652120486520676f74206c6f7374206174206120796f756e672061676520616e6420656e646564207570206265696e6720726169736564206279206120706563756c69617220736574206f6620706172656e74732e204a6f696e2068696d206173206865206c6f6f6b7320746f206d616b65206672656e73206f6e20686973206a6f75726e6579206578706c6f72696e672074686520696e7465726e65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_Wzl5_r_D_400x400_41b22a9010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

