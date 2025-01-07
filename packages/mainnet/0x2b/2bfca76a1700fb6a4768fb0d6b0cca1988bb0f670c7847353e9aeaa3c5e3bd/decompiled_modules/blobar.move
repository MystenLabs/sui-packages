module 0x2b2bfca76a1700fb6a4768fb0d6b0cca1988bb0f670c7847353e9aeaa3c5e3bd::blobar {
    struct BLOBAR has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOBAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLOBAR>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLOBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLOBAR>(arg0, 9, b"BLOBAR", b"The Blue Bobar", b"meme token of the year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXcLf7SXBXnnOHO15smsKuJ00zWfbja1O1TQ&s")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLOBAR>(&mut v3, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOBAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBAR>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLOBAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOBAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLOBAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

