module 0x49144d48ebdca9b331b354872e59bb94d9408f706b7de24940dc0e6aaaa4b013::suidigy {
    struct SUIDIGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDIGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDIGY>(arg0, 9, b"SUIDIGY", b"Dog On Sui Chill", b"Dog On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/f552b4808a985ab4d181882cc8c8ca6cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDIGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDIGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

