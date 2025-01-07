module 0xda920e9856c1d5dafd2ba34dd47339feb5d8de3b6c85f2009b9b0024a286af09::memtoken {
    struct MEMTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMTOKEN>(arg0, 9, b"MEMTOKEN", b"STM", b"STM MEMTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b31389d-5179-49f5-98f2-246fc131e59f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

