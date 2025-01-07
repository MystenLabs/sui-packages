module 0xc1d933d36d92ffef106376469f0cc66e6234be43220e0c516c623e9caae52db4::terbang {
    struct TERBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERBANG>(arg0, 9, b"TERBANG", b"Ikan", b"Everything will be Ok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8af4cf2-753a-4738-98a2-3639a9d5bb62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

