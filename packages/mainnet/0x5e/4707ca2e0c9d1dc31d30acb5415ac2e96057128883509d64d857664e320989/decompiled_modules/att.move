module 0x5e4707ca2e0c9d1dc31d30acb5415ac2e96057128883509d64d857664e320989::att {
    struct ATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATT>(arg0, 9, b"ATT", b"AloneTonight", x"546869732070726f6a656374206974277320666f722065766572796f6e65206974277320696e2074686973207370616365202e0a476f6f64206c75636b214c65742773207377696d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/beb3590c97fef349252c2d08726c4a7eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

