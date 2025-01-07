module 0x48a8ecb2f8e1d1e97cf0aac7aa643e33b2ea25ca610859a01879198d4729cf78::sevil {
    struct SEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVIL>(arg0, 6, b"SEVIL", b"Sevil on Sui", b"First Sevil on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_12_748486db1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

