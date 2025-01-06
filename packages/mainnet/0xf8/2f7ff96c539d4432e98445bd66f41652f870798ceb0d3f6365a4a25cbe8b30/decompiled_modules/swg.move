module 0xf82f7ff96c539d4432e98445bd66f41652f870798ceb0d3f6365a4a25cbe8b30::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 9, b"SWG", b"Suiwin Ghost", b"I am the ghost of SUIWINgame, a memecoin! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c7a52f22f0fc1622ecab4e738f6af0e8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

