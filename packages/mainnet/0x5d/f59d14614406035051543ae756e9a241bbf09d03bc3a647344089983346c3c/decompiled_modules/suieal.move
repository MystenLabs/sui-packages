module 0x5df59d14614406035051543ae756e9a241bbf09d03bc3a647344089983346c3c::suieal {
    struct SUIEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEAL>(arg0, 6, b"SUIEAL", b"SealSeal", b"We heard you like Seals! So we put a seal on your seal and wrapped it in a seal chain! Here to enjoy the party with all our ocean friends! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015704_d183a3eeaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

