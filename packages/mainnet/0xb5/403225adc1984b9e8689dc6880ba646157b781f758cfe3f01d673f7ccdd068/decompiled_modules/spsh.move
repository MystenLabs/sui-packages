module 0xb5403225adc1984b9e8689dc6880ba646157b781f758cfe3f01d673f7ccdd068::spsh {
    struct SPSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPSH>(arg0, 9, b"SPSH", b"Space Shuttle", b"lift off the ramp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aaeb7818024ac9265e5bbceccbe6b48eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

