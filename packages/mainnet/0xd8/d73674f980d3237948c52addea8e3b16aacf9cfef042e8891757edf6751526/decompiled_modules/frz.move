module 0xd8d73674f980d3237948c52addea8e3b16aacf9cfef042e8891757edf6751526::frz {
    struct FRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRZ>(arg0, 9, b"FRZ", b"FREEZ", b"frozen token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c57b15d-54e2-45ce-80d2-8fa51014547d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

