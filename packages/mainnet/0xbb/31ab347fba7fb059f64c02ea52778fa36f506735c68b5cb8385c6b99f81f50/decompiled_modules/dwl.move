module 0xbb31ab347fba7fb059f64c02ea52778fa36f506735c68b5cb8385c6b99f81f50::dwl {
    struct DWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWL>(arg0, 9, b"DWL", b"doodles with love", b"no to liqudity exit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a4cc12ac98e83202176c31d7f2297d27blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

