module 0x9aa615f6912d11fde63c83a08a08b0c260b90d15a3094f0627d47f5f18ba95a9::notrug {
    struct NOTRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTRUG>(arg0, 6, b"NOTRUG", b"NOTARUG", b"Definitely not a rug!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pirates3_500x500_50860577f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

