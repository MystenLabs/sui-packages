module 0x1f99c96ff9f2554bc54c60863bd4c78004447229f898075891330f569dd119b::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 9, b"FLAME", b"Sui on Flames", b"Sui is sizzling hot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c93ab77291bf51872380b1740de2e9d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

