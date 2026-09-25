module 0xa360404c029819375e96ee4aaccdcea2fd855cb161b7c57c7ee48bcf38206d08::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064554485941491145544859204147454e54204f4e20535549ca0143616c6c65642062792068747470733a2f2f782e636f6d2f437962756e5f4167656e742076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f7920746f6b656e204e616d65203a2045544859204147454e54204f4e20535549205469636b6572203a20244554485941492044657363203a20596f75722041492054726164696e6720417373697374616e742e2052756e732032342f3720736f20796f7520646f6ee2809974206861766520746f2e204465706c6f792072656164792f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485444696d79596230414141436a302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

