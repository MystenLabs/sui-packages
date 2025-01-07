module 0x9919b45d1178b4d8e855219b99c0080195d34cdeedce11d981538da979e84c3b::afg {
    struct AFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFG>(arg0, 9, b"AFG", b"KGR", b"Good morning I hope ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3c1e03d-e9b8-450d-a144-56267651938c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

