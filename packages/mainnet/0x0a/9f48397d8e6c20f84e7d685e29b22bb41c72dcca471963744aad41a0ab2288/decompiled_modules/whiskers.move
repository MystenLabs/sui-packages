module 0xa9f48397d8e6c20f84e7d685e29b22bb41c72dcca471963744aad41a0ab2288::whiskers {
    struct WHISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISKERS>(arg0, 6, b"WHISKERS", b"Captain Whiskers", b"A master of stealth, Captain Whiskers roams the urban ponds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91a2abc215c8ab9df3c44ce7102e1104_c9f579d051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

