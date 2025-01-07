module 0x2160d07227c5d8510af49644ce9d65cbaff22c4fa47586ffed855b24a960102d::flt {
    struct FLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLT>(arg0, 9, b"FLT", b"Four Leaf ", b"\"Do you believe in luck? #FLT - lucky cryptocurrency! Every time you buy FLT, you will own a digital lucky charm. Join the FLT community today to create good things together! #memecoin #crypto #luck\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d962809-3383-4d3d-9b8f-8d0da1e5a809.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

