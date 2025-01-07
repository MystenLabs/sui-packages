module 0x82707b9df35ebb616255f404e2cc2ad1eb5ac5b615120435b176ba45c5bb3b10::novel {
    struct NOVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVEL>(arg0, 9, b"NOVEL", b"novel", b"open-source novel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61ed5fc2-2b52-447b-acb7-324aaa39cc54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

