module 0x5ab8a75cd0b52da2d3a6476ebe5fad3264d5e148230208b34c2362c1babd114c::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 9, b"PTM", b"pump to the moon", b"It is a good project and will make a lot of money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8c45dd07abc56af7e1ab125543e58732blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

