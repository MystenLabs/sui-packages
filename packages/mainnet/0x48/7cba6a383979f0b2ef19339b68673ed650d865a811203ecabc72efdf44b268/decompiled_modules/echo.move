module 0x487cba6a383979f0b2ef19339b68673ed650d865a811203ecabc72efdf44b268::echo {
    struct ECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHO>(arg0, 6, b"ECHO", b"ECHO the SEAL", x"4543484f20746865205345414c206f6e205355490a0a4272696e67696e67207468652053554920436f6d6d756e69747920746f6765746865722077697468204543484f206e617669676174696e6720746865206869676820736561730a0a4543484f0a0a4541524e2043525950544f20482a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_500_x_500_px_a017b68419.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

