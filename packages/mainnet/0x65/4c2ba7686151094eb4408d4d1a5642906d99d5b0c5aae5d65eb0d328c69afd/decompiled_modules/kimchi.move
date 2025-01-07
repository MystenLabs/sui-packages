module 0x654c2ba7686151094eb4408d4d1a5642906d99d5b0c5aae5d65eb0d328c69afd::kimchi {
    struct KIMCHI has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<KIMCHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<KIMCHI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KIMCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<KIMCHI>(arg0, 6, b"KIMCHI", b"KIMCHI", b"JUST A KIMCHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747812549616156673/Sn5FAf65_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMCHI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<KIMCHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIMCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KIMCHI>(arg0, arg1, arg2, arg3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<KIMCHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<KIMCHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

