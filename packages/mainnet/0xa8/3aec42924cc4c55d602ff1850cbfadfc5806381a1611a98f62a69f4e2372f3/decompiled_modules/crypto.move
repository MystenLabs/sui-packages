module 0xa83aec42924cc4c55d602ff1850cbfadfc5806381a1611a98f62a69f4e2372f3::crypto {
    struct CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO>(arg0, 6, b"CRYPTO", b"The ticker is crypto", b"How did you make it? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_20_at_2_42_27_pm_4363e68e8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

