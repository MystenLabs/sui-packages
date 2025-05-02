module 0xae39fd54b0c3c574b9717d93ad0411674e04c77f934dc9143576eef79ce98886::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 9, b"HIP", b"HIPPO", b"MEME TOKEN FROM OKX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8185a9c793e267c423ba68aa73b05f33blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

