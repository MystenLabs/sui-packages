module 0x2acdb1e8cbc32486234e19875877469ddaf6f2b3d28e74e9dcff99c83ad3e852::komo {
    struct KOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMO>(arg0, 6, b"KOMO", b"Sui Komo", b"Meet Komo The most loyal dog on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020972_055a70b67f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

