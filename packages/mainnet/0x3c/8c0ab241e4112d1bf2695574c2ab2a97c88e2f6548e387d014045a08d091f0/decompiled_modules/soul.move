module 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    struct CoinPool has key {
        id: 0x2::object::UID,
        value: 0x2::balance::Balance<SOUL>,
        creater: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 0, b"SOUL", b"Soul", b"Soul Forest Game Tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss-of-ch1hiro.oss-cn-beijing.aliyuncs.com/imgs/202411241954102.png")), arg1);
        let v2 = v0;
        let v3 = CoinPool{
            id      : 0x2::object::new(arg1),
            value   : 0x2::balance::zero<SOUL>(),
            creater : 0x2::tx_context::sender(arg1),
        };
        0x2::balance::join<SOUL>(&mut v3.value, 0x2::coin::into_balance<SOUL>(0x2::coin::mint<SOUL>(&mut v2, 10000000, arg1)));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CoinPool>(v3);
    }

    public fun withdraw_task_low_token(arg0: &mut CoinPool) : 0x2::balance::Balance<SOUL> {
        0x2::balance::split<SOUL>(&mut arg0.value, 3)
    }

    // decompiled from Move bytecode v6
}

