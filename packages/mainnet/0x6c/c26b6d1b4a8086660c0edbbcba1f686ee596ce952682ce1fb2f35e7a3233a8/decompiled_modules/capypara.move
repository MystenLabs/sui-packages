module 0x6cc26b6d1b4a8086660c0edbbcba1f686ee596ce952682ce1fb2f35e7a3233a8::capypara {
    struct CAPYPARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYPARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYPARA>(arg0, 9, b"CAPYPARA", b"CAPYPARA A", b"CAPYPARA love ......................", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ed40973-1462-4d75-b8c5-03451223028b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYPARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYPARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

