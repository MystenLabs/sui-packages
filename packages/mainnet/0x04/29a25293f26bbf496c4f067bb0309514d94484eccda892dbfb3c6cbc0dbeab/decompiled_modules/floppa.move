module 0x429a25293f26bbf496c4f067bb0309514d94484eccda892dbfb3c6cbc0dbeab::floppa {
    struct FLOPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPA>(arg0, 6, b"Floppa", b"Floppa on Sui", b"Inspired by a memecoin on Base, where the developer sold his entire supply for $35k, the community has started to take over and is now sending it to gorillions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_4902223020106559096_y_c9f0adc5ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

