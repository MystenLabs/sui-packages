module 0x6e751cdb6c056b26c3ae3c9d21757e26008ae84e269367232bfa42bffc5860ab::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 6, b"LLAMA", b"Llama Llama Blue Pajama", x"4c6c616d61206c6c616d6120426c75652070616a616d610a4c697374656e73206b696e64612071756965740a466f2720686973206d616d610a576861742074686174206c6c616d6120646f696e273f0a4865277320626f6f2d686f6f696e27210a416e6420686f6f696e270a416e642049276d2073636577696e270a496d2074616b696e2720697420746f206164756c742076657273696f6e0a5768617427796120646f696e273f210a5275696e6564207275696e6564207275696e656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_15_08_43_079e0d0a8a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

