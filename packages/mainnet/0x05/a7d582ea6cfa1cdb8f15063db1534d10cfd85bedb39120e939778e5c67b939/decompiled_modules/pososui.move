module 0x5a7d582ea6cfa1cdb8f15063db1534d10cfd85bedb39120e939778e5c67b939::pososui {
    struct POSOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSOSUI>(arg0, 9, b"POSOSUI", b"The Poso SUI", b"SUI - POSOSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/527efe73e24dc940b66e83184dfa88d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

