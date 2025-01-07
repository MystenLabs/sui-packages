module 0x3effbdc855636fa00e59bd05478dbef60fa55f7113423339757772733ac47444::hallowkin {
    struct HALLOWKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWKIN>(arg0, 6, b"Hallowkin", b"Hallowkin SUI", b"Hallowkin, a cheerful pumpkin token under the SUI chain, emerges every Halloween to spread festive mischief. Hallowkins power grows, bringing new thrills to the SUI community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x322f835ef9ffd7e25a1edf00f8eed7b26fba77c59f1a257724f139c395f0983e_hallowkin_hallowkin_07af8fed3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

