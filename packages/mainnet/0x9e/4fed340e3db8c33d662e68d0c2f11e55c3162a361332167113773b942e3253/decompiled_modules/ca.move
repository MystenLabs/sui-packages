module 0x9e4fed340e3db8c33d662e68d0c2f11e55c3162a361332167113773b942e3253::ca {
    struct CA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA>(arg0, 6, b"Ca", b"0x000010010011001001", b"ca: 0x000010010011001001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdf_528fccab26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CA>>(v1);
    }

    // decompiled from Move bytecode v6
}

