module 0x1754e0f5d14358a57b018b0e4dad2d87e08a56be0be60dbba251c3239f6e557::hcetus {
    struct HCETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCETUS>(arg0, 6, b"HCETUS", b"HackedCetus", x"f09f90b3202448434554555320e2809320546865204f766572666c6f7720546861742044726f776e65642061204445580a0a2024484345545553206c616d706f6f6e732074686520696e66616d6f7573204d6179e280af32322ce280af3230323520436574757320444558206578706c6f6974206f6e205375692c2077686572652061206861636b657220757365642073706f6f6620746f6b656e7320616e6420616e20696e7465676572e280916f766572666c6f772062756720696e2061206d617468206c69627261727920746f207377616d70207468652070726f746f636f6ce28094737465616c696e67206f7665722024323230e280af6d696c6c69696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749569866453.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

