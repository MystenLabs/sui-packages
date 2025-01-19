module 0x1c24d129b3b03c6699a4eda9aadae425f1431ffc63e0c0bc9cd1899695000b01::elon_droid {
    struct ELON_DROID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON_DROID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 647 || 0x2::tx_context::epoch(arg1) == 648, 1);
        let (v0, v1) = 0x2::coin::create_currency<ELON_DROID>(arg0, 9, b"ELONDROID", b"Elon Droid", x"456c6f6e2041490a44726f6964204d6f64656c2054383530", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreihx677fseblfhjzg4tka2duw2avtntx3smxji6zypnvomq57yizzq.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELON_DROID>(&mut v2, 10000000000000000, @0x87669e5a6c3f669f7dd0444b936d5c32e70ed04415f9af7ffa572022b1773808, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON_DROID>>(v2, @0x87669e5a6c3f669f7dd0444b936d5c32e70ed04415f9af7ffa572022b1773808);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELON_DROID>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<ELON_DROID>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON_DROID>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<ELON_DROID>, arg1: &mut 0x2::coin::CoinMetadata<ELON_DROID>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<ELON_DROID>(arg0, arg1, arg2);
        0x2::coin::update_symbol<ELON_DROID>(arg0, arg1, arg3);
        0x2::coin::update_description<ELON_DROID>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<ELON_DROID>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

