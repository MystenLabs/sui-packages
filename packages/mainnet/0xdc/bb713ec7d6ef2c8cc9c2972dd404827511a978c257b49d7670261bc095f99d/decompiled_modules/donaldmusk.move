module 0xdcbb713ec7d6ef2c8cc9c2972dd404827511a978c257b49d7670261bc095f99d::donaldmusk {
    struct DONALDMUSK has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DONALDMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DONALDMUSK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DONALDMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DONALDMUSK>(arg0, 9, b"DonaldMusk", b"Donald Musk", b"Donald Musk Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DONALDMUSK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONALDMUSK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALDMUSK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DONALDMUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DONALDMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DONALDMUSK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

