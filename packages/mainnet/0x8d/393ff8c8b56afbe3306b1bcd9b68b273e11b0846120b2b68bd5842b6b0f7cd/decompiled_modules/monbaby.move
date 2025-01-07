module 0x8d393ff8c8b56afbe3306b1bcd9b68b273e11b0846120b2b68bd5842b6b0f7cd::monbaby {
    struct MONBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONBABY>(arg0, 9, b"MONBABY", b"MonkeyBaby", b"Monkey will be a meme animal in the crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc917222-bd58-4f5b-b92b-3a6e5a4b134d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

