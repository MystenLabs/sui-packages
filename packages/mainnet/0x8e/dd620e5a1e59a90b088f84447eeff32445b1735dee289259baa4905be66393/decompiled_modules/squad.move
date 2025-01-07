module 0x8edd620e5a1e59a90b088f84447eeff32445b1735dee289259baa4905be66393::squad {
    struct SQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAD>(arg0, 6, b"SQUAD", b"SUIcide Squad", b"Join the SUIcide $SQUAD and don't let your wallet suicide because you won't buy it !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_MOVEPUMP_0463c75ff1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

