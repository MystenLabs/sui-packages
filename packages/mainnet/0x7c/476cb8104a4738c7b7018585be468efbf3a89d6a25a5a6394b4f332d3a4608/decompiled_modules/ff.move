module 0x7c476cb8104a4738c7b7018585be468efbf3a89d6a25a5a6394b4f332d3a4608::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 9, b"FF", b"feflefl", b"xcvcvc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/770b635e85cb44c6e64a95765afed71bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

