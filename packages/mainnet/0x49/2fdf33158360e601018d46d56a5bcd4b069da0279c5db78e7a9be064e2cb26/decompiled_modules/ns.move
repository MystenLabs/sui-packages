module 0x492fdf33158360e601018d46d56a5bcd4b069da0279c5db78e7a9be064e2cb26::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 6, b"NS", b"Nice Scam", b"Sui Name Service devs keep dumping , lets run this higher than them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled1_20241128113720_6935f4663f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NS>>(v1);
    }

    // decompiled from Move bytecode v6
}

