module 0xbdebc4c058784224f4e8cbad33fbbcc6152c7e8a405719d66cb0faad6f38cab8::termiai {
    struct TERMIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMIAI>(arg0, 6, b"TERMIAI", b"Termiai Sui", b"Relentless innovation, unstoppable momentum! Our are grinding non-stop, cooking up greatness all day long. Big things are comingfill your bags with $TERMIAI before the rocket takes off! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060798_079bdcfe38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

