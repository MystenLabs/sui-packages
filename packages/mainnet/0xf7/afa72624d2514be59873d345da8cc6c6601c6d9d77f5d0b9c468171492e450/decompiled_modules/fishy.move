module 0xf7afa72624d2514be59873d345da8cc6c6601c6d9d77f5d0b9c468171492e450::fishy {
    struct FISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHY>(arg0, 6, b"FISHY", b"Fishy On Sui", b"$FISHY is the most unique and fortunate expressive fish in the Sui Ocean, staying true to its roots and bringing richness and dynamic energy to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001847_173aa572bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

