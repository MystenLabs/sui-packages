module 0x9a7fc949dbc39acb679ac3390d0db0577b7ec5ddff825a1d238ae94c1e9279ca::c2025 {
    struct C2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C2025>(arg0, 9, b"C2025", b"Christmas 2025", b"christmas is not over, it is paused for 12 months", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4627d7552214022cbb68d388a9b3c2eablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C2025>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C2025>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

