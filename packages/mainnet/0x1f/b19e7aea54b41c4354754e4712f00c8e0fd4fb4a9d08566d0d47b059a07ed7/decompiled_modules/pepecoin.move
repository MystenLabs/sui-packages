module 0x1fb19e7aea54b41c4354754e4712f00c8e0fd4fb4a9d08566d0d47b059a07ed7::pepecoin {
    struct PEPECOIN has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPECOIN>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_add<PEPECOIN>(arg0, arg1, arg2, arg4);
    }

    fun init(arg0: PEPECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPECOIN>(arg0, 9, b"PEPE", b"Pepe on Sui", b"https://n4eymquh3o3gtmjpzpr5jjikfuwn2n6b6v2lsxliep5c5ag6rcwa.arweave.net/bwmGQofbtmmxL8vj1KUKLSzdN8H1dLldaCP6LoDeiKw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://n4eymquh3o3gtmjpzpr5jjikfuwn2n6b6v2lsxliep5c5ag6rcwa.arweave.net/bwmGQofbtmmxL8vj1KUKLSzdN8H1dLldaCP6LoDeiKw"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPECOIN>>(v2);
        0x2::coin::mint_and_transfer<PEPECOIN>(&mut v3, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPECOIN>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = Owner{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Owner>(v4, 0x2::tx_context::sender(arg1));
    }

    fun is_owner(arg0: &0x2::tx_context::TxContext, arg1: &Owner) : bool {
        0x2::tx_context::sender(arg0) == arg1.owner
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPECOIN>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_remove<PEPECOIN>(arg0, arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

