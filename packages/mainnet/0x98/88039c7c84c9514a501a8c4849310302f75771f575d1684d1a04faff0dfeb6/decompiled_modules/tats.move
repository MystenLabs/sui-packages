module 0x9888039c7c84c9514a501a8c4849310302f75771f575d1684d1a04faff0dfeb6::tats {
    struct TATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATS>(arg0, 9, b"TATS", b"vansa", b"qwwq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/af3ad2fb09d0e4ab5672e5960285828eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

