module 0x1541aaa81ff8ef450cc69f5bd908397b5e908ef5ede96c215659c0aa01fa098c::nts {
    struct NTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTS>(arg0, 9, b"NTS", b"net215", b"2027", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8b9c7200e5fb0da6b17c2db482fdd339blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

