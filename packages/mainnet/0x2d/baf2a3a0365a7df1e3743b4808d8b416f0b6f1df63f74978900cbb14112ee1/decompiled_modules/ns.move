module 0x2dbaf2a3a0365a7df1e3743b4808d8b416f0b6f1df63f74978900cbb14112ee1::ns {
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

