module 0x987b17f70c15ae59740c521781cca9dd350af922c8f90040e2de385a6b8603a9::wifmagnet {
    struct WIFMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAGNET>(arg0, 6, b"WIFMAGNET", b"DOG WIF MAGNET", x"4d41474e45542049532042554c4c495348204d41524b45542c2057495448205749462031303078204d454d45205749494949460a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/639113_FA_BCEB_4_E12_A572_E3_C3_F8362_CAE_d6b508f7d9_b1b9826c99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

