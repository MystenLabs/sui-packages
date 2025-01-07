module 0x96a4f9b38eeb59690f82590f89295df32939c68fe3bde523b384f043fb541074::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 6, b"DRP", b"Droppy", b"Play the Droppy on Sui Telegram minigame ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t0_OC_Trba_400x400_7c794f4b74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

