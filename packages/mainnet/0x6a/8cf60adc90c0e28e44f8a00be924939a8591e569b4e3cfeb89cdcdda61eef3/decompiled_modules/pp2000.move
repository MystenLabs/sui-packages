module 0x6a8cf60adc90c0e28e44f8a00be924939a8591e569b4e3cfeb89cdcdda61eef3::pp2000 {
    struct PP2000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP2000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP2000>(arg0, 9, b"PP2000", b"PEPE2000", b"PEPE2000 is a fun and innovative meme-based cryptocurrency that celebrates the iconic Pepe meme culture. Designed for community engagement, it aims to empower users with unique rewards and opportunities while fostering a vibrant ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5466024-891c-4bce-ac67-e82b59eb016a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP2000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PP2000>>(v1);
    }

    // decompiled from Move bytecode v6
}

