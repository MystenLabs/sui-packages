module 0x1c55dc5b032b98efbad17e4cffc1389805716f82e757e73c8a1b447e8e72894c::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 9, b"TR", b"trump", b"trumPushka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e6bed397badcff31174e81fb039094f2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

