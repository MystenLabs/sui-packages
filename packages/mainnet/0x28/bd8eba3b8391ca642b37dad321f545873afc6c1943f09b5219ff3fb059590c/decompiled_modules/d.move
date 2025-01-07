module 0x28bd8eba3b8391ca642b37dad321f545873afc6c1943f09b5219ff3fb059590c::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 9, b"D", b"TH", b"B", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1dd01c2-d9ff-4965-af65-ad286732d5ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D>>(v1);
    }

    // decompiled from Move bytecode v6
}

