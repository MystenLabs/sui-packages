module 0xe8b1b94cfaaa3b72bdc0b7f6e51615fa3736f756b429cc8e8517ca4ac39935a2::afrok {
    struct AFROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFROK>(arg0, 6, b"AFROK", b"Angry Pepe Fork", b"Angry Pepe is a meme coin for those who are adults and want to have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015298_1c79eb9028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

