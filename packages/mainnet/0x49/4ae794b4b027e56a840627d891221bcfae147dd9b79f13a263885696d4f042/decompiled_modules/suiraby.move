module 0x494ae794b4b027e56a840627d891221bcfae147dd9b79f13a263885696d4f042::suiraby {
    struct SUIRABY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIRABY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIRABY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIRABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIRABY>(arg0, 9, b"SuiRaby", b"SUI Rabbit", b"meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5XzhiGWcW55SRrhI2CvnXFlXkxU0FMZoP7g&s")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIRABY>(&mut v3, 9990000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRABY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRABY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIRABY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIRABY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIRABY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

