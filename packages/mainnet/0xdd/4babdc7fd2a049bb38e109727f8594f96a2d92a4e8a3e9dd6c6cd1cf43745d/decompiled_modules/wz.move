module 0xdd4babdc7fd2a049bb38e109727f8594f96a2d92a4e8a3e9dd6c6cd1cf43745d::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 9, b"WZ", b"wangzai", b"wangzaixiaowang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/19cc204211efcf71946355a59a18e2aablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

