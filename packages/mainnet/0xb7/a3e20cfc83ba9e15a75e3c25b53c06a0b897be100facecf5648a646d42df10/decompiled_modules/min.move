module 0xb7a3e20cfc83ba9e15a75e3c25b53c06a0b897be100facecf5648a646d42df10::min {
    struct MIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIN>(arg0, 9, b"MIN", b"Mint", b"This is a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c298fb3d4b5da9c4cadd20328046b5efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

