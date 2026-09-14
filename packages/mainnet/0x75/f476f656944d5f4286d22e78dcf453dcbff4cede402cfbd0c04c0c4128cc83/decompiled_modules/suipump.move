module 0x75f476f656944d5f4286d22e78dcf453dcbff4cede402cfbd0c04c0c4128cc83::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"08534841524b53554908536861726b737569b601426f726e2066726f6d2074686520646570746873206f6620746865205375692065636f73797374656d2c2053756920536861726b206973206120666561726c657373206d656d652d706f776572656420636861726163746572207377696d6d696e67207468726f7567682074686520626c6f636b636861696e206f6365616e2e20466173742c206167677265737369767c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f73756970756d7031227d4968747470733a2f2f692e6962622e636f2f36376446514e59762f372d4644332d424143312d4135392d462d342d44392d442d3836352d422d333230373136352d45323939312e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

