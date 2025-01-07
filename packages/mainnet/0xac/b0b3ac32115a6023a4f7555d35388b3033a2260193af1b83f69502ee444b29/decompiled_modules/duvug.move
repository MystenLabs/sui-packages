module 0xacb0b3ac32115a6023a4f7555d35388b3033a2260193af1b83f69502ee444b29::duvug {
    struct DUVUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUVUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUVUG>(arg0, 6, b"Duvug", b"Duvu", b"People tell me i look retarded. I tell them It wont stop me to become an ultimate meme coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014997_a68aa282c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUVUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUVUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

