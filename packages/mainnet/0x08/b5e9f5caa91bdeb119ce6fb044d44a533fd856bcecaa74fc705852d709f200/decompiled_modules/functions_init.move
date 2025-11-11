module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_init {
    public(friend) fun init_contract<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<T0>(arg0, 6, b"$YLDS", b"YLDS", b"YLDS is the first SEC-registered, yield-bearing stablecoin combining the liquidity of traditional stablecoins, the safety of a security, and the earning power of a money market fund", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.datocms-assets.com/119559/1752675020-ylds.svg")), true, arg1);
        let v3 = v1;
        let v4 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(v2);
        let v5 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::new_ylds_admin_cap(arg1);
        let v6 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::new_deny_list_manager_cap(arg1);
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v4, v7);
        0x2::transfer::public_transfer<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap>(v5, v7);
        0x2::transfer::public_transfer<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap>(v6, v7);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<T0>>(v3, v7);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::share_root(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::new_root<T0>(arg1, &v4, &v5, &v6, &v3));
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_admin::emit_admin_event(0x1::string::utf8(b"deploy_ylds"), v7, 0x1::string::utf8(b"YLDS is issued by Figure Certificate Company"));
    }

    // decompiled from Move bytecode v6
}

