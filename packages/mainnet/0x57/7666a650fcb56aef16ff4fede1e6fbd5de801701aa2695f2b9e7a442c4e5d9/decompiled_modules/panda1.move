module 0x577666a650fcb56aef16ff4fede1e6fbd5de801701aa2695f2b9e7a442c4e5d9::panda1 {
    struct PANDA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA1>(arg0, 9, b"Panda1", b"Panda", b"New mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d64e71325b2d50300f4169173b8b7c9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

