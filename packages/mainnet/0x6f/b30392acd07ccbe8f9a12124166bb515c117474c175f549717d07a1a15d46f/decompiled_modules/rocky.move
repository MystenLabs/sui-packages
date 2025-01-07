module 0x6fb30392acd07ccbe8f9a12124166bb515c117474c175f549717d07a1a15d46f::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"ROCKY", b"Rocky Stone", b"just stone and silence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rock_removebg_preview_b111be9a48.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

