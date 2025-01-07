module 0x9722dcc11e31653901f1e8e95dff8fbb8f725b65a72ef128555c50354fea1b52::bluedolphy {
    struct BLUEDOLPHY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEDOLPHY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEDOLPHY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUEDOLPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEDOLPHY>(arg0, 9, b"BlueDolphy", b"Sui Blue Dolphy", b"Sui Blue Dolphy Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/hand-drawn-cartoon-cute-blue-dolphin_584573-631.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEDOLPHY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDOLPHY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOLPHY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEDOLPHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEDOLPHY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEDOLPHY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

