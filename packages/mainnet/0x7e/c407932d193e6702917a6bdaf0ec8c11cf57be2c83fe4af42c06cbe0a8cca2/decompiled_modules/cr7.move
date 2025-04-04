module 0x7ec407932d193e6702917a6bdaf0ec8c11cf57be2c83fe4af42c06cbe0a8cca2::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 9, b"CR7", b"suiiiiiiii", b"suuuuuuuuuiiiiiiiiiiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9cae6f19a783446d72c3f30657fcb604blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

