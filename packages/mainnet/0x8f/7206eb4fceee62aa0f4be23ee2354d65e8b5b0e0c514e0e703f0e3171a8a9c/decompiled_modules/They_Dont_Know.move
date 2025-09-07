module 0x8f7206eb4fceee62aa0f4be23ee2354d65e8b5b0e0c514e0e703f0e3171a8a9c::They_Dont_Know {
    struct THEY_DONT_KNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEY_DONT_KNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEY_DONT_KNOW>(arg0, 9, b"TDK", b"They Dont Know", b"they dont know i have $THEYDONTKNOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0MXM_GW4AAyX34?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEY_DONT_KNOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEY_DONT_KNOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

