module 0x630550d7629ee92cdec4cdad37d3daa2cdbe0bf64c5c943af05e34935fd66ca8::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04505354441d506f737420547261756d617469632053746f6e6b204469736f72646572ae015054534420576172642031362e32302e31392e30342e20446570742e206f66204265686176696f7572616c2046696e616e63657c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f506f7374547261756d6174696353746f6e6b4469736f72646572222c2274776974746572223a2268747470733a2f2f782e636f6d2f5054534453746f6e6b222c2277656273697465223a2268747470733a2f2f707473642e66756e642f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61326139313536306634303138333664396539616333303061636331313937372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

