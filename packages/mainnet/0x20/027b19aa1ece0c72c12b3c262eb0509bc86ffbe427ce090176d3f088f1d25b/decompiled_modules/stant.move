module 0x20027b19aa1ece0c72c12b3c262eb0509bc86ffbe427ce090176d3f088f1d25b::stant {
    struct STANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANT>(arg0, 9, b"STANT", b"SupThorAnt", b"In a world desperate for a super heroes, we look up to the sky, is it a bird? An aeroplane? No it's Super Thor ANT, welding Miulnr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bfb8ab6-e712-4cb0-90d3-01076a7f6118.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

