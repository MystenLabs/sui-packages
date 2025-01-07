module 0xbcfb881b630fb81586c5ce0dd43eb1e280d1ad65d9e23e545a5f54d4355152f6::toon {
    struct TOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOON>(arg0, 6, b"TOOn", b"ToonOnsui", b"$TOON on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000346_0be7341a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

