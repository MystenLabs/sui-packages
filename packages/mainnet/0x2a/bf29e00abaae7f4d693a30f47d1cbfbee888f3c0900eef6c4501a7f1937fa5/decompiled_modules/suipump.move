module 0x2abf29e00abaae7f4d693a30f47d1cbfbee888f3c0900eef6c4501a7f1937fa5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064755445355490773756920656767ad0143616c6c65642062792068747470733a2f2f782e636f6d2f68616c745f61622076696120404f7572626c617374626f742022617920406f7572626c617374626f74206c61756e63682061206d656d65204e616d65203a2073756920656767205469636b6572203a202467756473756920496d616765203a2053657420406d6a626472616e206173206665652072656365697665722068747470733a2f2f742e636f2f4148554d664c576e797a222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4853302d315845573841417164484b2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

