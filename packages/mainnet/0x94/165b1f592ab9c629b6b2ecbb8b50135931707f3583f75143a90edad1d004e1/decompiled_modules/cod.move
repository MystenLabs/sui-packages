module 0x94165b1f592ab9c629b6b2ecbb8b50135931707f3583f75143a90edad1d004e1::cod {
    struct COD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COD>(arg0, 9, b"COD", b"THE CODE", b"here to code to success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d8f103cfe21f5734623d1ecca7fce4fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

