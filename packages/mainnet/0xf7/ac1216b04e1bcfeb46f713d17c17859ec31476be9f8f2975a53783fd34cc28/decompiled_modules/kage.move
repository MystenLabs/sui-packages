module 0xf7ac1216b04e1bcfeb46f713d17c17859ec31476be9f8f2975a53783fd34cc28::kage {
    struct KAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGE>(arg0, 6, b"KAGE", b"KAGE SOCIETY", b"From the shadows, we rise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TX_4_a_Cbx_400x400_2c388b4153.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

