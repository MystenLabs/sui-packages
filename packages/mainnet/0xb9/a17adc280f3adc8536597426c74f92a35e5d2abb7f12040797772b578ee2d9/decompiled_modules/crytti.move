module 0xb9a17adc280f3adc8536597426c74f92a35e5d2abb7f12040797772b578ee2d9::crytti {
    struct CRYTTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYTTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYTTI>(arg0, 9, b"CRYTTI", b"crytti name", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e983b9368e1ef0073045565b5310df3ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYTTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYTTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

