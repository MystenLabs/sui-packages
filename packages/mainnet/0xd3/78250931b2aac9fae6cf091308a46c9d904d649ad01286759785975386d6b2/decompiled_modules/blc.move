module 0xd378250931b2aac9fae6cf091308a46c9d904d649ad01286759785975386d6b2::blc {
    struct BLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLC>(arg0, 9, b"BLC", b"Balance ", b"Meme equity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff6403b0-83a7-42d3-8414-cb8ef4f9d3ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

