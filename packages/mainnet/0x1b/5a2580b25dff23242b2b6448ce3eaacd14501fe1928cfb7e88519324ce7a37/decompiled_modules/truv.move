module 0x1b5a2580b25dff23242b2b6448ce3eaacd14501fe1928cfb7e88519324ce7a37::truv {
    struct TRUV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUV>(arg0, 6, b"TRUV", b"Truv", b"Truv is a penguin that loves to be treated like a king. Bring him food to his bed or hell eat you alive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_05_28_T224054_200_13323aa787.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUV>>(v1);
    }

    // decompiled from Move bytecode v6
}

