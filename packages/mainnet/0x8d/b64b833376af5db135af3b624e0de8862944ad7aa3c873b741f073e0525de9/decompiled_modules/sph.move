module 0x8db64b833376af5db135af3b624e0de8862944ad7aa3c873b741f073e0525de9::sph {
    struct SPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPH>(arg0, 9, b"Sph", b"separuh", b"coin meme better meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8c9a42f63acf35845c8412cfdf2f5af3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

