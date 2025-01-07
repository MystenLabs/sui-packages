module 0x582e4686ce564a79d9bb806a94bf43947f3539c13f4fbb33f1612844b85e4ac3::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 634 || 0x2::tx_context::epoch(arg1) == 635, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 4, b"Sushi", b"Sushi", x"5768696c65207072696d6172696c792061206d656d6520636f696e2c2053757368692074656173657320667574757265207573652063617365732c2073756368206173204e46547320666561747572696e672061646f7261626c65207375736869206172742c2067616d6966696564204465466920696e746567726174696f6e7320287468696e6b2022537573686920426174746c657322292c20616e6420706172746e657273686970732077697468207265616c2d776f726c6420737573686920636861696e732e0a4d61726b6574696e673a20537573686920436f696e2074687269766573206f6e2068756d6f722c20636c657665722073757368692d72656c617465642070756e732c20616e6420766972616c2063616d706169676e7320746861742073707265616420697473206272616e64206163726f73732074686520696e7465726e6574206c696b65207370696379207761736162692e0a537573686920436f696e20646f65736ee28099742070726f6d69736520746f207265766f6c7574696f6e697a652066696e616e63653b2069742070726f6d6973657320746f206d616b65207468652063727970746f20776f726c642061206c6f74206d6f72652066756e207768696c6520796f7520726f6c6c207769746820697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreic6l6ch2bt6s3seh2t53i6kifce5or3alsz7umolxegp332fx3zvi.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUSHI>(&mut v2, 10000000000, @0xcb1570da4a1e42b538e12a67b4031366c01d9a81e4205f0ee93e327b98fb8e35, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v2, @0xcb1570da4a1e42b538e12a67b4031366c01d9a81e4205f0ee93e327b98fb8e35);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUSHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<SUSHI>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHI>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<SUSHI>, arg1: &mut 0x2::coin::CoinMetadata<SUSHI>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<SUSHI>(arg0, arg1, arg2);
        0x2::coin::update_symbol<SUSHI>(arg0, arg1, arg3);
        0x2::coin::update_description<SUSHI>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<SUSHI>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

