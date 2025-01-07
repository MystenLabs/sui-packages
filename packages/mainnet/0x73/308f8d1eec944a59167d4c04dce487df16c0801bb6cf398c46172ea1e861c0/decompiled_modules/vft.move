module 0x73308f8d1eec944a59167d4c04dce487df16c0801bb6cf398c46172ea1e861c0::vft {
    struct VFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VFT>(arg0, 6, b"VFT", b"Vesse Food Tracker  by SuiAI", b"BUY ONLy ON turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ik4i_Ui_Fx_400x400_670f65c268.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

