module 0x987f6cb37c0fa653cc98ae5b923bf1a36e2801cf9eb24ba4b538454c4ebb1463::goodies {
    struct GOODIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODIES>(arg0, 6, b"Goodies", b"Sui G00dies", b" The cutest faces of Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goodies_53a3e143ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOODIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

