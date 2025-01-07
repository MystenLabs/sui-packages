module 0x450c2008026af061ae56910a8b04afe2dd7fcc2e6bf86700a9a3fa0259f6cdb6::pb {
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

