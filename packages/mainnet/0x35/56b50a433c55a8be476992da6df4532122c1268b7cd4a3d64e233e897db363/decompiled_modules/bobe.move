module 0x3556b50a433c55a8be476992da6df4532122c1268b7cd4a3d64e233e897db363::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"BOBE RECOVERY", x"616e642049207472756c792061706f6c6f67697a6520746f2074686f73652077686f2068617665206265656e206861726d65642c204920686f70652074686572652077696c6c206265206e6f206d6f7265206675636b6564207570206861636b6572732061726f756e642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039409_41d2a1c319.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

