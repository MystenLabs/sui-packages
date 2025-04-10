module 0x4def37343b131627f18cfc79116669228ff63668cc5f3ab10f50f6da9e30d920::swr {
    struct SWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWR>(arg0, 9, b"SWR", b"Sawer", b"comunity give a way token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dffaa84f7cccf0a2b86575edde01db11blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

