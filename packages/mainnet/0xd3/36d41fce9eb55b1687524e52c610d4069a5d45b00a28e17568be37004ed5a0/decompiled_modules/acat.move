module 0xd336d41fce9eb55b1687524e52c610d4069a5d45b00a28e17568be37004ed5a0::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ACAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ACAT>(arg0, 9, b"ACAT", b"AquaCAT", b"Aqua Cat will dominate the cryto meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/blue-futuristic-cat-ai-generated_768802-1679.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ACAT>(&mut v3, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ACAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ACAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

