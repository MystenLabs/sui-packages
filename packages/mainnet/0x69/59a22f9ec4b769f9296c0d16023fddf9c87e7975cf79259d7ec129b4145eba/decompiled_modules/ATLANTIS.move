module 0x6959a22f9ec4b769f9296c0d16023fddf9c87e7975cf79259d7ec129b4145eba::ATLANTIS {
    struct ATLANTIS has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ATLANTIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ATLANTIS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ATLANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ATLANTIS>(arg0, 9, b"CAT", b"CAT MILLIONS", b"CAT MILLIONS AI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ATLANTIS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATLANTIS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLANTIS>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ATLANTIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ATLANTIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ATLANTIS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

