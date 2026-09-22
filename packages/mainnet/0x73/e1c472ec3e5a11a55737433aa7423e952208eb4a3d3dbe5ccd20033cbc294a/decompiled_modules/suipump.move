module 0x73e1c472ec3e5a11a55737433aa7423e952208eb4a3d3dbe5ccd20033cbc294a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03434c4507436c65616e6572df0153756920436c65616e65722068656c70732053756920757365727320636c65616e2074686569722077616c6c6574732c2072656d6f766520756e77616e746564206173736574732c20616e64207265636f7665722073746f7261676520726562617465732e2053696d706c652c206e6f6e2d637573746f6469616c2077616c6c657420636c65616e757020666f72205375692e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f537569436c65616e6572222c2277656273697465223a2268747470733a2f2f737569636c65616e65722e66756e2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f31313034653562623761316537643532616330333563656234343437303366612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

