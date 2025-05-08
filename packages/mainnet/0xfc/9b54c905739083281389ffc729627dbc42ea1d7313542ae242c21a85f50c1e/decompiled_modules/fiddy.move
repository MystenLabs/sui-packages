module 0xfc9b54c905739083281389ffc729627dbc42ea1d7313542ae242c21a85f50c1e::fiddy {
    struct FIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIDDY>(arg0, 9, b"Fiddy", b"fiddymon", b"coin interistic and visual ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0a105a7228e0ad4ac0299831a9ccccf8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

