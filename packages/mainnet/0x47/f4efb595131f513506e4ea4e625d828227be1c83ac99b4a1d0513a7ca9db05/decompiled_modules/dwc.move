module 0x47f4efb595131f513506e4ea4e625d828227be1c83ac99b4a1d0513a7ca9db05::dwc {
    struct DWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWC>(arg0, 6, b"DWC", b"Dog Wif Croc", b"dog wif croc the cute dog and ugly dog on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3698_7f4b71e6d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

