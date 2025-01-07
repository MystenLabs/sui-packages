module 0xd21ddef3a30244baef0bd19d864bae271a341f27034da7716fa7d4261a3a7b0e::saki {
    struct SAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKI>(arg0, 6, b"SAKI", b"Saki", b"Now Saki is known as the cutest shark on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_18_T235417_557_56ba06d192.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

