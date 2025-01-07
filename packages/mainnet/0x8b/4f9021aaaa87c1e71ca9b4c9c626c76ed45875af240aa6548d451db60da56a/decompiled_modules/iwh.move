module 0x8b4f9021aaaa87c1e71ca9b4c9c626c76ed45875af240aa6548d451db60da56a::iwh {
    struct IWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWH>(arg0, 6, b"IWH", b"IrohWifHat", b"Iroh will bring us to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_12_04_377758dcaf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

