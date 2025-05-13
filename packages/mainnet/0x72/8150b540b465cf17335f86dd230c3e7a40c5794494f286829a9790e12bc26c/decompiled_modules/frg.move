module 0x728150b540b465cf17335f86dd230c3e7a40c5794494f286829a9790e12bc26c::frg {
    struct FRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRG>(arg0, 9, b"FRG", b"AI FROG", b"Little animals, frogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/380a487a2b8d9a00a2d99110268214b4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

