module 0x4d55591ce2bfcdcdf35cf89127b9d9de9919978381bfe788fb4ba9c50d715d01::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DC>(arg0, 9, b"DC", b"DUCK & CAT", b"EVERYTHING WILL CHANGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdee9c57-d6e8-4586-86d9-850dfcddb508.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DC>>(v1);
    }

    // decompiled from Move bytecode v6
}

