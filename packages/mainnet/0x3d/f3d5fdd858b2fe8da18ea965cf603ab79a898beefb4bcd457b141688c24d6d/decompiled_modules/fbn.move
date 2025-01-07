module 0x3df3d5fdd858b2fe8da18ea965cf603ab79a898beefb4bcd457b141688c24d6d::fbn {
    struct FBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBN>(arg0, 9, b"FBN", b"YYYYYYYY", b"CVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c8bcdfc-f730-46fe-b0a6-a58e728613a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

