module 0xe8a24a32ef4aa3e6b98bf23685dc1bab7f3440ae4c3a74a442b3d019b32dae12::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 9, b"THO", b"Thomas", b"dfsdfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b4cea9716d9a6779265095e40af67537blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

