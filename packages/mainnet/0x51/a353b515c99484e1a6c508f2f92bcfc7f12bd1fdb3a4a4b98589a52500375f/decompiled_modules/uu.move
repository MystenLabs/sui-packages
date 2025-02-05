module 0x51a353b515c99484e1a6c508f2f92bcfc7f12bd1fdb3a4a4b98589a52500375f::uu {
    struct UU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UU>(arg0, 9, b"UU", b"YE", b"O7O979OI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e6f0a29671f35c4ed8ae2d22bf7fc59bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

