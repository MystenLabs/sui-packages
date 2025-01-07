module 0x8e92cfd6a3c31983b664a04a049c13032317581a546c1d3a53a7bfc274d65c11::vxsdv {
    struct VXSDV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXSDV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXSDV>(arg0, 9, b"VXSDV", b"Gvcxz", b"Vsvvddf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bb48641-c6a8-41b4-bcc0-6f5742a464ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXSDV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VXSDV>>(v1);
    }

    // decompiled from Move bytecode v6
}

