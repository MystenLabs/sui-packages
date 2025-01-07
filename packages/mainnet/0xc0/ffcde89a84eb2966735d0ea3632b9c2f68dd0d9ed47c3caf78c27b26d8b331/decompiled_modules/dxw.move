module 0xc0ffcde89a84eb2966735d0ea3632b9c2f68dd0d9ed47c3caf78c27b26d8b331::dxw {
    struct DXW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXW>(arg0, 9, b"DXW", b"DEX WEVE", b"Dex wave is a community project on sui network. To promote wewe culture pad and Dexscreen tool....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3142dbb2-8c35-4972-a810-5afc2120ef4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXW>>(v1);
    }

    // decompiled from Move bytecode v6
}

