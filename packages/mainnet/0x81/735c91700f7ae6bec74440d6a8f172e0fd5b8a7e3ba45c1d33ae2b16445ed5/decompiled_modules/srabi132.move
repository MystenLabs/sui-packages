module 0x81735c91700f7ae6bec74440d6a8f172e0fd5b8a7e3ba45c1d33ae2b16445ed5::srabi132 {
    struct SRABI132 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRABI132, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRABI132>(arg0, 9, b"Srabi132", b"srabi", b"Kent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc9128be9db56db9d9e756fbd8bd44a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRABI132>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRABI132>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

