module 0xb8c8d256f76626cec29fadbfdb21037053efe3396f385946d061d44c7c886334::chiyo {
    struct CHIYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIYO>(arg0, 6, b"Chiyo", b"chiyo", b"cat has a unique, beautiful coat of fur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e255a83568e942b74eafb8388c46a29f_1715fc4635.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

