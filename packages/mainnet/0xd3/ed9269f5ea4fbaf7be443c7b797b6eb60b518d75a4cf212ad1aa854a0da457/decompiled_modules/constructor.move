module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::constructor {
    public fun create_all_vaults<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg6: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg6);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::create_vault<T1, T0>(arg4, arg0, arg1, arg2, arg3, arg7);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_vault::create_vault<T1, T0>(arg7);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::async_vault::create_vault<T1, T0>(arg7);
    }

    public(friend) fun create_coin<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = b"gr";
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = b"Grow-";
        0x1::vector::append<u8>(&mut v1, arg1);
        let v2 = if (0x1::vector::is_empty<u8>(&arg3)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg3))
        };
        let (v3, v4) = 0x2::coin::create_currency<T0>(arg0, 9, v0, v1, arg2, v2, arg4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v3, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::create_version(arg0);
    }

    // decompiled from Move bytecode v6
}

