module 0x53287640a4e0b1a3590dda3b06b5f9992523990006ac7701c5aebfe7c760f5b9::pb {
    struct PB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PB>(arg0, 6, b"PB", b"Pandora's Box", x"576861742077696c6c2050616e646f7261277320426f7820676976650a4e6f206f6e65206b6e6f77732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241210_192616235_6ace2dfcae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PB>>(v1);
    }

    // decompiled from Move bytecode v6
}

