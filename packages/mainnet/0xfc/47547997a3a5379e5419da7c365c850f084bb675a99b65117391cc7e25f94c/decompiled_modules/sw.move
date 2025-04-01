module 0xfc47547997a3a5379e5419da7c365c850f084bb675a99b65117391cc7e25f94c::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 9, b"SW", b"SuiWal", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29ba93d3fe641b7860356864a527b6a0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

