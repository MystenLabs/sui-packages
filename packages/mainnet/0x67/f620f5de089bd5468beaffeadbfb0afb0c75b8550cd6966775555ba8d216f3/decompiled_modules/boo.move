module 0x67f620f5de089bd5468beaffeadbfb0afb0c75b8550cd6966775555ba8d216f3::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 9, b"BOO", b"booblik", x"d0bcd0bcd0bcd0bcd0bcd0bcd0bcd0bc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6d05fa3905d732d5fc6e21c02a26fa8dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

