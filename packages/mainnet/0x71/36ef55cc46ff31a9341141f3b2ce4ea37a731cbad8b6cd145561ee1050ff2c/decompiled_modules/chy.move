module 0x7136ef55cc46ff31a9341141f3b2ce4ea37a731cbad8b6cd145561ee1050ff2c::chy {
    struct CHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHY>(arg0, 9, b"CHY", b"chunky", b"Get hefty returns with ChunkyCoin: The robust cryptocurrency that's delivering weighty profits and solid gains, making a big impact in the crypto market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/674d0e48-4488-448b-9969-55fe1cefeb78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

