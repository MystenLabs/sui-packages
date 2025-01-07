module 0x29e6568e74a864ac5a1558150d36fc787b1b1f9b02f472afe4ec22266e807536::wlf {
    struct WLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 6, b"WLF", b"World Liberty Financial", b"A chance to help shape the future of Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ttowetttt_b195d90626.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

