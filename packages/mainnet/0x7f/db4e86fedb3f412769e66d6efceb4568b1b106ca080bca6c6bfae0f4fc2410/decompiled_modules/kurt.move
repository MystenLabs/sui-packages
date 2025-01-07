module 0x7fdb4e86fedb3f412769e66d6efceb4568b1b106ca080bca6c6bfae0f4fc2410::kurt {
    struct KURT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURT>(arg0, 6, b"KURT", b"Kurt On Sui", b"KURT WON'T GO OUT. As far back as I can remember, people always called me a loser. But I promised myself, Im not leaving this room until I find that one gem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_a3fd88f9c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KURT>>(v1);
    }

    // decompiled from Move bytecode v6
}

