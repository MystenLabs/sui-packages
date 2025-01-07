module 0x79060c2c415fc91db5654a9bce15176a51081f8378d330af930ba642502bbb77::cointemp {
    struct COINTEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINTEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINTEMP>(arg0, 9, b"COINTEMP", b"MEOEMEOE", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/91544881288e951f69dbd78d675a356bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINTEMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINTEMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

