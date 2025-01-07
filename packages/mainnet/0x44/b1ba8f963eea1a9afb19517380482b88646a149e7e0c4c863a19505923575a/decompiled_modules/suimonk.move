module 0x44b1ba8f963eea1a9afb19517380482b88646a149e7e0c4c863a19505923575a::suimonk {
    struct SUIMONK has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMONK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIMONK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIMONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIMONK>(arg0, 9, b"BlueMonk", b"Sui Blue Monk", b"Meme that did 6853x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIMONK>(&mut v3, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMONK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIMONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMONK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIMONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

