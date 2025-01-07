module 0x91687cf3ee5cd354a07859723a6cbdb5d814cd79f10e393ec280c43dea75f32::racat {
    struct RACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACAT>(arg0, 9, b"RACAT", b"Nora", b"Community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fd7294c-cdb4-4e3d-9fed-ab507362024d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

