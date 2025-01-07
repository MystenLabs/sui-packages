module 0x3dc6c0b3bdff673257f3fa86eebe7ae33154c9a62166dbb95929d727a7bc8e99::kunefe {
    struct KUNEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUNEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNEFE>(arg0, 6, b"KUNEFE", b"Sui Kunefe", b"i am a kunefe eat me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_224004_960fbbb9cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUNEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

