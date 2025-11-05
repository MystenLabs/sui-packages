module 0xe7a8d7392ed54e4ad60e43b3af8ce4dcaf591c499c2d11c93bb6ca1c245b0504::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin_registry::Currency<ABC>, arg1: &0x2::coin_registry::MetadataCap<ABC>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_icon_url<ABC>(arg0, arg1, arg2);
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ABC>(arg0, 9, 0x1::string::utf8(b"abc"), 0x1::string::utf8(b"ABC"), 0x1::string::utf8(b"A decentralized currency for the people, by the people."), 0x1::string::utf8(b"https://illustoon.com/photo/12737.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::mint_and_transfer<ABC>(&mut v2, 10000000000000, @0xc7958f8e343ab039a9913e3c494a3d73f5883677059a3584bdeae1d0c191fa9, arg1);
        0x2::coin_registry::make_supply_fixed_init<ABC>(&mut v3, v2);
        0x2::transfer::public_share_object<0x2::coin_registry::MetadataCap<ABC>>(0x2::coin_registry::finalize<ABC>(v3, arg1));
    }

    // decompiled from Move bytecode v6
}

