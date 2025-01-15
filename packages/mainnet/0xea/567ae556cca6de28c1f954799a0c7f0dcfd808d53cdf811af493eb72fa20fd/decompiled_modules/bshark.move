module 0xea567ae556cca6de28c1f954799a0c7f0dcfd808d53cdf811af493eb72fa20fd::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark", b"Meet the fastest creature in the sea Advanced Sniper Bot +  AI Agent +  Dynamic PFP NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullshark_f14db26696.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

