module 0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::constructor {
    public fun create_coin<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun create_vault<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg6: &0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::version::assert_current_version(arg6);
        0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::grow_vault::create_vault<T1, T0>(arg4, arg0, arg1, arg2, arg3, arg7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::version::create_version(arg0);
    }

    // decompiled from Move bytecode v6
}

