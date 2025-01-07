module 0xa233737bcabb538b1fe79958cfd75bbc441342b804dd1b163e2163a7484cd572::suigan {
    struct SUIGAN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"suigan", b"SUIGAN TOKAN", b"SUIIIIIIGGGANNNNNN HEEEEYA PAMP PAMP PMAP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GaqMNtPbYAEtpSE?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIGAN>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIGAN>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

