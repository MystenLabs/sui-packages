module 0xd9387612f2136123016d8ca599edad4ede6a51c9550e72990e29dae897c8224e::suipemario {
    struct SUIPEMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEMARIO>(arg0, 9, b"SUIPEMARIO", b"Suiper Mario 64", b"SUPER MARIO SUI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmX5gyxZRZ3bQgs18w1NZQX21AXyAMYJaCGsPtKLPDGseZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPEMARIO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEMARIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

