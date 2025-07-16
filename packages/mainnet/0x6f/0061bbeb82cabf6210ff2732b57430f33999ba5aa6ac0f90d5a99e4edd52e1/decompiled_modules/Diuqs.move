module 0x6f0061bbeb82cabf6210ff2732b57430f33999ba5aa6ac0f90d5a99e4edd52e1::Diuqs {
    struct DIUQS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIUQS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIUQS>(arg0, 9, b"SQUID1", b"Diuqs", b"squid backwards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/932313014241435648/cDpqFAqZ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIUQS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIUQS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

