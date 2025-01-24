module 0xe1c6a698c89babc95831bf5bc928376005c8512aec16459a340b7202a6c32791::psh {
    struct PSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSH>(arg0, 9, b"PSH", b"Paris Hilton", b"Paris Hilton , BFT fan, by Andy Warhol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/76ec1716bd277beaac7463eb39029ef6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

