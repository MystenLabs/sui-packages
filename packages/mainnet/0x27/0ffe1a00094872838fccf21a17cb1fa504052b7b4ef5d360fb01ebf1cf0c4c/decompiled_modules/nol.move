module 0x270ffe1a00094872838fccf21a17cb1fa504052b7b4ef5d360fb01ebf1cf0c4c::nol {
    struct NOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOL>(arg0, 9, b"NOL", b"New token No Lock", b"No lock token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/f9d1d8896918a0ce92228dfce4b9957eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

