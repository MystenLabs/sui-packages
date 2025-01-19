module 0xabd30155231d21cb6cebfecd88005e4927307d762fa4b6c24d4f9b30497f538e::donald_droid {
    struct DONALD_DROID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD_DROID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 647 || 0x2::tx_context::epoch(arg1) == 648, 1);
        let (v0, v1) = 0x2::coin::create_currency<DONALD_DROID>(arg0, 9, b"DONDROID", b"Donald Droid", x"54686520446f6e616c64200a44726f6964204d6f64656c2054383030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreien4xh5zcz4sjjsk5vwgban2zytwmlg7thmstkzuxbasxco53gqu4.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONALD_DROID>(&mut v2, 10000000000000000, @0x87669e5a6c3f669f7dd0444b936d5c32e70ed04415f9af7ffa572022b1773808, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD_DROID>>(v2, @0x87669e5a6c3f669f7dd0444b936d5c32e70ed04415f9af7ffa572022b1773808);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONALD_DROID>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<DONALD_DROID>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONALD_DROID>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<DONALD_DROID>, arg1: &mut 0x2::coin::CoinMetadata<DONALD_DROID>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<DONALD_DROID>(arg0, arg1, arg2);
        0x2::coin::update_symbol<DONALD_DROID>(arg0, arg1, arg3);
        0x2::coin::update_description<DONALD_DROID>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<DONALD_DROID>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

