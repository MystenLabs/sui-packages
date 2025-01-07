module 0x8a47877b99c3147251982861728213af008716ae5417eda77ac6d98a6955f32b::sdawg {
    struct SDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDAWG>(arg0, 6, b"Sdawg", b"Suidawg", b"Dawg da sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000599031_56f553e952.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

