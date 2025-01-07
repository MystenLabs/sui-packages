module 0x1c3b7288e21893e0ad1c1d984dc9f7f5d9a0a2f04b878e73a5b6b1cc802a07d4::spaicex {
    struct SPAICEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAICEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAICEX>(arg0, 6, b"SpAiceX", b"SpAiceX on Sui", b"SpAiceX on sui. Hold and bonded together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004946_01b28e8835.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAICEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAICEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

