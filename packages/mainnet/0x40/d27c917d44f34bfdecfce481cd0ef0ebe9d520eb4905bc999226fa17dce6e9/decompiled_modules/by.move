module 0x40d27c917d44f34bfdecfce481cd0ef0ebe9d520eb4905bc999226fa17dce6e9::by {
    struct BY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY>(arg0, 9, b"BY", b"boy", b"boy bue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a612a86d222176988afcf5aa0554ead0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

