module 0x727e0b65e983fae7a0a6ebc5da3c6f99e55cade90383898d74cca2f9001b03e0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"035a554b07535549205a554bed01535549205a554b206973206120636f6d6d756e6974792d706f7765726564206d656d6520746f6b656e206f6e205375692c206275696c742061726f756e6420612073696d706c6520696465613a205a554b2068617320656e746572656420746865205375692074696d656c696e652e20f09f8c8af09f92a720497420697320696e737069726564206279204164656e69796920636f20666f756e646572206f66206d797374656e206c61622e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f32313032313536393831353430383838383231227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f36643561386530343761633032656134626430616264633737363832636561382e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

