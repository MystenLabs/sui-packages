module 0xef3a328dc12fca8b5997341c3a40dfa2365893f18b980bf6b0da51b13ba71cc1::suivy {
    struct SUIVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVY>(arg0, 6, b"SuiVy", b"Clavy On Sui", b"THE MOST CUTE DOG ON THE WEB3 #SUI NETWORK Launched On http://Movepump.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000211823_c0bed0a15d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

