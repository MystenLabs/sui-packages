module 0xc29df08716ea893707eaa5f84dc044c8ae109297cd7c88fdd885c632eecc7c8f::lpc {
    struct LPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPC>(arg0, 6, b"LPC", b"Lick paw cat", b"cat licking their paw, er- sucking their paw 101", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/76008a171f0820417edfcb6c95727af1_f0e3e9a8ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

