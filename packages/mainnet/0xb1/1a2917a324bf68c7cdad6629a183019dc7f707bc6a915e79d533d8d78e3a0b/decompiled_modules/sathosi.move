module 0xb11a2917a324bf68c7cdad6629a183019dc7f707bc6a915e79d533d8d78e3a0b::sathosi {
    struct SATHOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATHOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATHOSI>(arg0, 6, b"SATHOSI", b"satoshi nakamoto", b"satoshi nakamoto revealed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sato_1021bcb14d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATHOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATHOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

