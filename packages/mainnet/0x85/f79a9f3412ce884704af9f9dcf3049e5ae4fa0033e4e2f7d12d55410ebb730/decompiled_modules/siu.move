module 0x85f79a9f3412ce884704af9f9dcf3049e5ae4fa0033e4e2f7d12d55410ebb730::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIU on SUI", b"Cristiano Ronaldo SIUUUUUUU!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siu_edbd3e5e51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

