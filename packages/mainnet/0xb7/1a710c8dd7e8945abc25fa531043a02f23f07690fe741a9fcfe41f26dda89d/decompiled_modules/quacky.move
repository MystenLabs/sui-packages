module 0xb71a710c8dd7e8945abc25fa531043a02f23f07690fe741a9fcfe41f26dda89d::quacky {
    struct QUACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACKY>(arg0, 6, b"QUACKY", b"Quacky", b"Meet Quacky, a Matt Furie Character on Sui. Let's Dominate!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_a5e2eab793.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

