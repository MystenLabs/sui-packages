module 0xad1aaa72189a6ffd1491b283fe67fdde72cf6aa80b98efb42a185e70bc90eac8::fudog {
    struct FUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDOG>(arg0, 6, b"FUDOG", b"FU DOG", b"Born from the legends of ancient China, Fu Dog stands as the ultimate guardian. This legendary Lion Dog isnt just chilling outside temples anymore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Des1_0126586ada.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

