module 0x31cb09eb0362a1bdeddee9427d2ce308e0c4319b51098af88acbbe1c662ae3ee::bitmonkey {
    struct BITMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMONKEY>(arg0, 6, b"BITMONKEY", b"Bitmonkey", b"BITMONKEY On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitmonkey_a690ee862a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

