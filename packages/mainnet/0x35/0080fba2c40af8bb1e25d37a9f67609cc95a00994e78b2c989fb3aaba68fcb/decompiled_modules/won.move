module 0x350080fba2c40af8bb1e25d37a9f67609cc95a00994e78b2c989fb3aaba68fcb::won {
    struct WON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WON>(arg0, 9, b"Won", b"Wonderlog", b"This coin will make you a rich monkey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0ab2e1a564cefb62b2b4830f4cfcdaeeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

