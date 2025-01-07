module 0x61c973df323c3889d1a68ca8b7eefb21f6b9f2eff72f3dfdc548e8d2adf6e4f9::fuckpump {
    struct FUCKPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKPUMP>(arg0, 6, b"FuckPump", b"Fuck MovePump", b"Fuck  movepump scammer. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5489_d5549320c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

