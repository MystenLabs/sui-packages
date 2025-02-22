module 0x1225426deef6da74b685306a3a155f17337fb058c047ca35719f206f746177e0::tdbs {
    struct TDBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDBS>(arg0, 6, b"TDBS", b"TeddyBear", b"Let's explore interesting things on Sui Network with Teddy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Efour_Digital_Pro_6faa97da86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

