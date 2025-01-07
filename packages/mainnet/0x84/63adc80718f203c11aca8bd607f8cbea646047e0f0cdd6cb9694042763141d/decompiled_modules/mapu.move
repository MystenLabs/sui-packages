module 0x8463adc80718f203c11aca8bd607f8cbea646047e0f0cdd6cb9694042763141d::mapu {
    struct MAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPU>(arg0, 6, b"MAPU", b"Murad Apustaja", b"$MAPU - Inspired by SUI coin, on a mission to free the city from taxes. Community-driven rebellion, built on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_024038_c208fc0f16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

