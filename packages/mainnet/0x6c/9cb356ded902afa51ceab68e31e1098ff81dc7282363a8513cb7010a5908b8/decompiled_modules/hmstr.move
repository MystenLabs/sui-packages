module 0x6c9cb356ded902afa51ceab68e31e1098ff81dc7282363a8513cb7010a5908b8::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"HMSTR", b"RICH SUI HAMSTER", b"IN SUI WE TRUST!GET RICH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_547c1ae913.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

