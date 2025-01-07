module 0xe9fa2f4cdb8b6f4dbd766dee026d0597a5a0f3f606059d9725f3c1dcc4b84599::dxw {
    struct DXW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXW>(arg0, 9, b"DXW", b"Dex wave ", b"Dex wave is a community project on sui network. To promote wewe culture pad and Dexscreen tool....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c890bb96-94f1-4a2a-9ef3-c8a914984bed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXW>>(v1);
    }

    // decompiled from Move bytecode v6
}

