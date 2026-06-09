module 0xca555f990acdf3177f1ffddf1aa7c08c65e861103c09cd934e5ba153d4f26739::suilah {
    struct SUILAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAH>(arg0, 6, b"Suilah", b"Sui Lah", b"This is SUILAH, your lucky charm and spell for good fortune. Just place it in your wallet and let the good luck flow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0050_245b1d93ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

