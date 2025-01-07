module 0x7eae76b0dd909b706a42aab58661011e2a733240f4741019a9de5dcf295f0731::prd {
    struct PRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRD>(arg0, 9, b"PRD", b"PARODY ", b"A meme in support of the sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16baf9dc-e9c4-4df1-8422-4bb66246a612.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

