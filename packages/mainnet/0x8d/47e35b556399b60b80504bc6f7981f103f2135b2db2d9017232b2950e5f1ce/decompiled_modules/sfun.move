module 0x8d47e35b556399b60b80504bc6f7981f103f2135b2db2d9017232b2950e5f1ce::sfun {
    struct SFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFUN>(arg0, 6, b"SFUN", b"SUIFUN", b"Spin and Win while enjoying fast payouts total anonymity and provably fair gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_01_23_02_44_c6040a2caf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

