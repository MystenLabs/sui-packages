module 0x79b7c523982d40c1a63ba80f677bc6585c8507cf8a125e6cc0132bec5458acee::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIGHT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FIGHT>>(0x2::coin::mint<FIGHT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"FIGHT", b"Fight!Fight!Fight!For MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dmm7xtfkpq556n2f6yxzuqkgoqojzlicytvf5fnixue4bjiq7hpa.arweave.net/Gxn7zKp8O983RfYvmkFGdBycrQLE6l6VqL0JwKUQ-d4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

