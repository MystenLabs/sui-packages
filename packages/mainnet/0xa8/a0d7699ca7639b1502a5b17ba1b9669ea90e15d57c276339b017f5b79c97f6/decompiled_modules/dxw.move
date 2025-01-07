module 0xa8a0d7699ca7639b1502a5b17ba1b9669ea90e15d57c276339b017f5b79c97f6::dxw {
    struct DXW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXW>(arg0, 9, b"DXW", b"Dex wave ", b"Dex wave is a community project on sui network. To promote wewe culture pad and Dexscreen tool....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fda829d5-f83d-48f6-b7e5-ed7829931660.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXW>>(v1);
    }

    // decompiled from Move bytecode v6
}

