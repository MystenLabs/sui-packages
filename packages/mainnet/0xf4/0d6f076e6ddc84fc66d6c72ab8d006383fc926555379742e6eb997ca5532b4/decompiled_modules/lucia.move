module 0xf40d6f076e6ddc84fc66d6c72ab8d006383fc926555379742e6eb997ca5532b4::lucia {
    struct LUCIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCIA>(arg0, 9, b"Lucia", b"WII", b"POV: Its Summer 2007", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29aca19f370d6aef525bf7992a162057blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

