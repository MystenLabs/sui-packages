module 0x668448e56b14008a0e28c6bc049b626e6f2e810ccad31c230b0e0aecc7c83ccc::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 6, b"CATI", b"CatizenAI", b" Catizen's vibe: Play for airdrop, Heal the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catizen_fb1760c11a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

