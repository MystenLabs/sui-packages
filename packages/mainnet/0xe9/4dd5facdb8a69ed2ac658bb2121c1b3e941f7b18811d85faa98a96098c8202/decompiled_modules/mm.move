module 0xe94dd5facdb8a69ed2ac658bb2121c1b3e941f7b18811d85faa98a96098c8202::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"dfasdf", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2931297fb31845765c2cf4360f9acb6dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

