module 0xd874248418b9de20ad5c8f4ef3e853c449f0be65fb9d33bbd8ef1ecb6e10cf34::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"SUI CULT", b"Telling the truth since day one! The CULT is REAL . Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibzluoixlintjpe2ebbu3o7hujkp63yvnx4hh2edqtwyl7jlapt7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

