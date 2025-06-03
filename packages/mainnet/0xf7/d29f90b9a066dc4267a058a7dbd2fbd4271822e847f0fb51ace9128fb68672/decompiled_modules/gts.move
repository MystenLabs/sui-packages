module 0xf7d29f90b9a066dc4267a058a7dbd2fbd4271822e847f0fb51ace9128fb68672::gts {
    struct GTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTS>(arg0, 9, b"GTS", b"GT SUI", b"GT3 on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f08b3919f86e9dc5680b4b2f2042812blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

