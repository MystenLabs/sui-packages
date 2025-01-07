module 0x31bd441e644d50c268f9c92857483f2f48cea3f03af41df49b77ba6af67a04bb::pekeb {
    struct PEKEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEKEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEKEB>(arg0, 9, b"PEKEB", b"BI oen", b"veveb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66dc442d-31a3-403b-a9af-762c5b7c9690.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEKEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEKEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

