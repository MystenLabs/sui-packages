module 0xd42f62265f650e495c2cd407985c29e9813ea7646336b7fb9672da7e611fc01f::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUILAMA>(arg0, 9, untag(b"SSUILAMA"), untag(b"NSuilama"), untag(x"445375696c616d6120556e7665696c7320746865204f6666696369616c20e28098556e6f6666696369616ce2809920535549204d6173636f742c206120436f72706f72617465204d617276656c20696e207468652053554920426c6f636b636861696e2e"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiglz7du54y4yfaogrsy7zz2t2o5uyyx33dlzshrlykfdjglvxomre"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUILAMA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUILAMA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILAMA>>(0x2::coin::mint<SUILAMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

