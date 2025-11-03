module 0xe4b1278aa0a55114bd5124994ae853397403dda41f529537bd5b33d1cb0c3615::block {
    struct BLOCK has drop {
        dummy_field: bool,
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin_registry::Currency<BLOCK>, arg1: &0x2::coin_registry::MetadataCap<BLOCK>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_icon_url<BLOCK>(arg0, arg1, arg2);
    }

    fun init(arg0: BLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLOCK>(arg0, 9, 0x1::string::utf8(b"BLK"), 0x1::string::utf8(b"BLOCK"), 0x1::string::utf8(b"A decentralized currency for the people, by the people."), 0x1::string::utf8(b"https://effervescent-yeot-ddb372.netlify.app/"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLOCK>(&mut v2, 10000000000000000000, @0xc7958f8e343ab039a9913e3c494a3d73f5883677059a3584bdeae1d0c191fa9, arg1);
        0x2::coin_registry::make_supply_fixed_init<BLOCK>(&mut v3, v2);
        0x2::transfer::public_share_object<0x2::coin_registry::MetadataCap<BLOCK>>(0x2::coin_registry::finalize<BLOCK>(v3, arg1));
    }

    // decompiled from Move bytecode v6
}

