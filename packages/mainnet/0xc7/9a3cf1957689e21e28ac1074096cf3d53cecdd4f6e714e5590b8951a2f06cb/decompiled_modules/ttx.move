module 0xc79a3cf1957689e21e28ac1074096cf3d53cecdd4f6e714e5590b8951a2f06cb::ttx {
    struct TTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTX>(arg0, 9, b"TTX", b"TRUMTAX ", b"If you don't buy me, I will impose a tax of 1488% on you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c84464dc0f0fd54de840c0ef6093ba36blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

