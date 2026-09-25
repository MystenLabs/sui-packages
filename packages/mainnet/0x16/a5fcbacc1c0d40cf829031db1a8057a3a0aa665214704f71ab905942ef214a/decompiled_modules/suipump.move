module 0x16a5fcbacc1c0d40cf829031db1a8057a3a0aa665214704f71ab905942ef214a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"075346414d494c590a5355492046414d494c59930143616c6c65642062792068747470733a2f2f782e636f6d2f61656f6e666c75786e657665722076696120404f7572626c617374626f742022404f7572626c617374626f74206c61756e636820746f6b656e206e616d65203a205355492046414d494c59205449434b4552205346414d494c5920696d616765203a2068747470733a2f2f742e636f2f4c456b4e506a5132716b222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f48544339577149626741414b6b32732e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

