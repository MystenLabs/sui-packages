module 0xb957ab73d5150d7700d659eef595189e6075398ebc449d0944698d4d85e0a594::blubber {
    struct BLUBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBBER>(arg0, 6, b"BLUBBER", b"Blubber The Whale", b"Meet Blubber. The majestic whale on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blubber_25dd09e12e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

