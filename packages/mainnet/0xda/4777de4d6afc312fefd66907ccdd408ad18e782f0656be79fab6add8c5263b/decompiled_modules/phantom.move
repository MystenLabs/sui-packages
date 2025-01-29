module 0xda4777de4d6afc312fefd66907ccdd408ad18e782f0656be79fab6add8c5263b::phantom {
    struct PHANTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOM>(arg0, 6, b"PHANTOM", b"PHANTOM X SUI", b"Welcome to SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_29_08_36_25_84fcbca2c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

