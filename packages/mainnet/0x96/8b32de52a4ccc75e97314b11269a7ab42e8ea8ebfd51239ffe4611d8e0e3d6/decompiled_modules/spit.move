module 0x968b32de52a4ccc75e97314b11269a7ab42e8ea8ebfd51239ffe4611d8e0e3d6::spit {
    struct SPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIT>(arg0, 6, b"SPIT", b"SuiPit", b"\"SuiPit is more than just a meme  it's a commitment to security and reliability on the Sui blockchain. Our top priority is safeguarding our users' assets by using best practices for auditing and implementing robust smart contracts. With a focus on transparency and trust, SuiPit aims to be a fun and secure meme coin that brings community and innovation together in one place.\"only have X Twitter as a social network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sw_Odug_UX_400x400_8fdba4e443.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

