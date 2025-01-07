module 0x48f8a543601d14f762e96142f66c17dfe3d7eee77ada4b9a8a126f1e656de9aa::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 6, b"SUIDOGE", b"Sui Dogecoin", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/VJscGcM/OIG-7.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
        0x2::coin::mint_and_transfer<SUIDOGE>(&mut v2, 139490026384000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

