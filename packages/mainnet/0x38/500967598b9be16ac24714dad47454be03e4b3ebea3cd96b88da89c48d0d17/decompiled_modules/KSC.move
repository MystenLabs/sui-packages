module 0x38500967598b9be16ac24714dad47454be03e4b3ebea3cd96b88da89c48d0d17::KSC {
    struct KSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSC>(arg0, 6, b"KSC", b"Kermit Suicide", b"Clone of the other kermit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmQqim4mUoWsauZHZyXEj95hXXkRub6E3aSqgEGX3PxsKN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

