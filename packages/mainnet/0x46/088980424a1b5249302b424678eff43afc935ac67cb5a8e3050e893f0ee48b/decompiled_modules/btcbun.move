module 0x46088980424a1b5249302b424678eff43afc935ac67cb5a8e3050e893f0ee48b::btcbun {
    struct BTCBUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCBUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCBUN>(arg0, 9, b"BTCBUN", b"Little squirrel", b"I collect and hide nuts. Are you with me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b57448f4e6971db7f2aa10c5e43479cdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCBUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCBUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

