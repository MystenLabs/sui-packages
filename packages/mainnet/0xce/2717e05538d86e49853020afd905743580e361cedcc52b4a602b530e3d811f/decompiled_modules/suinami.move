module 0xce2717e05538d86e49853020afd905743580e361cedcc52b4a602b530e3d811f::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"WAVE", b"SUINAMI", x"526964652074686520245741564520f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreihqdwfda6klbxl6w5w36y4vrbmod5s5lzkeuo6i5puqbwl3s6osze.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINAMI>(&mut v2, 1000000000000000000, @0xdb65aa7335c21999b6b68f057e6d2898aa9695c7c946cfe3f86b6a45ac17a88e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v2, @0xdb65aa7335c21999b6b68f057e6d2898aa9695c7c946cfe3f86b6a45ac17a88e);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINAMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<SUINAMI>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMI>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: &mut 0x2::coin::CoinMetadata<SUINAMI>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<SUINAMI>(arg0, arg1, arg2);
        0x2::coin::update_symbol<SUINAMI>(arg0, arg1, arg3);
        0x2::coin::update_description<SUINAMI>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<SUINAMI>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

