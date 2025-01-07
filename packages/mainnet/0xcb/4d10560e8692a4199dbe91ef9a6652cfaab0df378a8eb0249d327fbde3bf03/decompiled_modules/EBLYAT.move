module 0xcb4d10560e8692a4199dbe91ef9a6652cfaab0df378a8eb0249d327fbde3bf03::EBLYAT {
    struct EBLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBLYAT>(arg0, 9, b"EBLYAT", b"EBLYAT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-blushing-woodpecker-143.mypinata.cloud/ipfs/Qmed2qynTAszs9SiZZpf58QeXcNcYgPnu6XzkD4oeLacU4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBLYAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBLYAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EBLYAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EBLYAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

