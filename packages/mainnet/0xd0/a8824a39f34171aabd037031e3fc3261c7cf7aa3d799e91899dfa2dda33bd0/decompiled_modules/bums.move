module 0xd0a8824a39f34171aabd037031e3fc3261c7cf7aa3d799e91899dfa2dda33bd0::bums {
    struct BUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMS>(arg0, 6, b"BUMS", b"Bums Sui", b"Fans of Bums_Official. We are powered by Sui Blockchain. Bums_of_Sui_Blockchain ARE YOU READY?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000622_9e86cb7295.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

