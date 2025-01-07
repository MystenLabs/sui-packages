module 0xbdd8b0d18daa6281a3f07aa2718b771dd68085be2df484852cd83a071a7adcb::lk {
    struct LK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LK>(arg0, 9, b"LK", b"Licas", b"Licas to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/01c3c9389ee83a0de2c21100f96855acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

