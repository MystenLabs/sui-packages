module 0x8849f2877b3f507ffcf30f189c32b8b4b3b7d1053477940a238e273ed5d29a76::xyz {
    struct XYZ has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<XYZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XYZ>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 617 || 0x2::tx_context::epoch(arg1) == 618, 1);
        let (v0, v1) = 0x2::coin::create_currency<XYZ>(arg0, 7, b"XYZ", b"XYZ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreib6nq5gwx5ctoizc53ngovukgj7gyfffuq6mnzlhur63tlceb25ne.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XYZ>(&mut v2, 71111111110000000, @0xabff96e39b48be075b705f2842a613f63457c8e3764436c6809e517d0786ba81, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZ>>(v2, @0xabff96e39b48be075b705f2842a613f63457c8e3764436c6809e517d0786ba81);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XYZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<XYZ>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYZ>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<XYZ>, arg1: &mut 0x2::coin::CoinMetadata<XYZ>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<XYZ>(arg0, arg1, arg2);
        0x2::coin::update_symbol<XYZ>(arg0, arg1, arg3);
        0x2::coin::update_description<XYZ>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<XYZ>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

