module 0x74b612eb0149b8ba2135a7be53391276ce3c46496aa3ff976a65db38a08a7891::crzypeop {
    struct CRZYPEOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRZYPEOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRZYPEOP>(arg0, 6, b"CRZYPEOP", b"crazy people", b"We are crazy about sui coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022147_aab43c7c23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRZYPEOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRZYPEOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

