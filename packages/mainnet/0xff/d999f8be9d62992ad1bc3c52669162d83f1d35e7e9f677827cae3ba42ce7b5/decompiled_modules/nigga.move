module 0xffd999f8be9d62992ad1bc3c52669162d83f1d35e7e9f677827cae3ba42ce7b5::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 9, b"NIGGA", b"Gay Who Ever Sells", b"Don't give a shit a bout the money... I give a shit about men being gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a95cf268e69ce830a4f31228b71979afblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

