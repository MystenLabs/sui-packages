module 0xb64e7446262f0a06fe0b9d604565ab8440706bd74c34041aecde4e6ef33a08e::popsuicle {
    struct POPSUICLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUICLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUICLE>(arg0, 6, b"POPSUICLE", b"PopSUIcle", x"506f70737569636c6520697320612066756e20616e642072656672657368696e67206d656d65636f696e20696e7370697265642062792065766572796f6e6573206661766f7269746520696379207472656174202074686520706f707369636c6521204a757374206c696b65206120706f707369636c65206f6e206120686f74206461792c20506f70737569636c65206973206865726520746f206272696e6720736f6d65206368696c6c20766962657320616e6420736d696c657320746f207468652063727970746f20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_867dd02565.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUICLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSUICLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

