module 0xf15bee7138c19a95185c5a35fd018e09e7d83ea4c50e5a012a18026d0b4ab9a1::suimonkey {
    struct SUIMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONKEY>(arg0, 6, b"SUIMONKEY", b"SUI MONKEY", b"The first monkey on SUI! Bullishhh ASF! Lets go buddies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/monyy_ce097df4d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

