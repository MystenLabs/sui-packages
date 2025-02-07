module 0x518276905c069a40a26119b269c2ed6216a395b554f4e0eb959d86fc1ddf13e5::mofos {
    struct MOFOS has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MOFOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOFOS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MOFOS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 666 || 0x2::tx_context::epoch(arg1) == 667, 1);
        let (v0, v1) = 0x2::coin::create_currency<MOFOS>(arg0, 9, b"MOF", b"MoFoS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOFOS>(&mut v2, 1000000000000000, @0xd7cb4030db2d33e8d3a7b198572c77c2a3d3cb6bf8ab090e13640392a8282f11, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOFOS>>(v2, @0xd7cb4030db2d33e8d3a7b198572c77c2a3d3cb6bf8ab090e13640392a8282f11);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOFOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<MOFOS>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOFOS>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<MOFOS>, arg1: &mut 0x2::coin::CoinMetadata<MOFOS>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<MOFOS>(arg0, arg1, arg2);
        0x2::coin::update_symbol<MOFOS>(arg0, arg1, arg3);
        0x2::coin::update_description<MOFOS>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<MOFOS>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

