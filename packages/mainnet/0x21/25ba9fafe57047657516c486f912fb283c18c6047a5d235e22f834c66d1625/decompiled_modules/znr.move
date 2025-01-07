module 0x2125ba9fafe57047657516c486f912fb283c18c6047a5d235e22f834c66d1625::znr {
    struct ZNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZNR>(arg0, 6, b"ZNR", b"ZORNER", b"Prepare yourself first with extensive experience and knowledge because this coin is very challenging, prepare yourself as much as possible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul43_20241020091610_722347cc0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

