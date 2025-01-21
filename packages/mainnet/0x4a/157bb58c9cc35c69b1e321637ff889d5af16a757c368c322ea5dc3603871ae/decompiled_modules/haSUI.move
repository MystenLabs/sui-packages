module 0x4a157bb58c9cc35c69b1e321637ff889d5af16a757c368c322ea5dc3603871ae::haSUI {
    struct HASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUI>(arg0, 9, b"haSUI", b"Haedal staked SUI", b"haSUI is a staking token of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.haedal.xyz/logos/hasui.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HASUI>>(0x2::coin::mint<HASUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HASUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

