module 0x78812583089afbfd27266090017b6499ba5ecfce3f433168661afe2b8ca1e936::thangs {
    struct THANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANGS>(arg0, 6, b"THANGS", b"Sui Thangs", b"$THANGS - spit on that thang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048127_1cfffb49a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

