module 0x78487341aad2b83f0632210f6cf3ad0e2d3020bacc7c0ed2767c5ff7d527a75f::swng {
    struct SWNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWNG>(arg0, 9, b"SWNG", b"WOODSWING", b"nostalgic and charming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ebfd953-d422-4338-80f9-4c3f7478a836.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

