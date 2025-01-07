module 0x3613bba681c9209f84b1f37f76dbb36dba64c5d6e091231359905318c8f2d2ad::sutato {
    struct SUTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTATO>(arg0, 6, b"SUTATO", b"SUITATO", b"Tato, your favorite memecoin on SUI is back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_8_Uk_1_D_400x400_copy_f919f8647c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

