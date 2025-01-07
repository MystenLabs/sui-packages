module 0x8b38d417cc26841189700e9674029a66a064a23881e45ff6894571f3352b6c04::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 6, b"SQUI", b"Squi on Sui", b"$SQUI is the cutest mollusc to ever grace the depths of the $Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/de2aa068_d5ae_474d_99f5_82f836ee48f8_5012706bbe.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

