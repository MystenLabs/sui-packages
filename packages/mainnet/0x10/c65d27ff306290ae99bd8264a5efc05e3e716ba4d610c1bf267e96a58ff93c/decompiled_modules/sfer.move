module 0x10c65d27ff306290ae99bd8264a5efc05e3e716ba4d610c1bf267e96a58ff93c::sfer {
    struct SFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFER>(arg0, 6, b"SFER", b"Sui Mfer", b"Sui is a muthafucka!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_0479f5d609.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

