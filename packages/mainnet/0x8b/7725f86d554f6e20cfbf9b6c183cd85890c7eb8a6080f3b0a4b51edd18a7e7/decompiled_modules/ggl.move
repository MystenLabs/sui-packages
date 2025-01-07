module 0x8b7725f86d554f6e20cfbf9b6c183cd85890c7eb8a6080f3b0a4b51edd18a7e7::ggl {
    struct GGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGL>(arg0, 6, b"Ggl", b"Google", b"Google ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000258875_02b4e00877.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

