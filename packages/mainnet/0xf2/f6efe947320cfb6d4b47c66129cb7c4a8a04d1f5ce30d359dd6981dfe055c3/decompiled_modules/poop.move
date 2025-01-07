module 0xf2f6efe947320cfb6d4b47c66129cb7c4a8a04d1f5ce30d359dd6981dfe055c3::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"PoopBirds Sui", b"$POOP meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wifxa5_f9889ae192.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

