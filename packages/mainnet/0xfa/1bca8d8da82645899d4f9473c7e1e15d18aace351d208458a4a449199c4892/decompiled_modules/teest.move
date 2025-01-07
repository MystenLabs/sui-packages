module 0xfa1bca8d8da82645899d4f9473c7e1e15d18aace351d208458a4a449199c4892::teest {
    struct TEEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEST, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 600 || 0x2::tx_context::epoch(arg1) == 601, 1);
        let (v0, v1) = 0x2::coin::create_currency<TEEST>(arg0, 9, b"TSTH", b"TestHash", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEEST>(&mut v2, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEST>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TEEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEEST>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<TEEST>, arg1: &mut 0x2::coin::CoinMetadata<TEEST>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TEEST>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TEEST>(arg0, arg1, arg3);
        0x2::coin::update_description<TEEST>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TEEST>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

