module 0xa13533318af0b20cd4339781d867b51b0e22353034b39ea1f1e91940c317457d::tnz {
    struct TNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNZ>(arg0, 9, b"TNZ", b"Toonez ", b"It's just a fan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06704ef9-1848-4376-ab2a-ed51a3ef239f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

