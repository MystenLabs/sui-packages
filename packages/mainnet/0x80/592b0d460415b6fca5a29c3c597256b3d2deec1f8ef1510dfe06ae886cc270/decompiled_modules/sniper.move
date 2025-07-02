module 0x80592b0d460415b6fca5a29c3c597256b3d2deec1f8ef1510dfe06ae886cc270::sniper {
    struct SNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPER>(arg0, 6, b"Sniper", b"Snip", b"Dont buy or gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie2gunylnaccsuqngs2e6zeg5hjebocpsyxsbvjkiqiq5tyuuy5gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

