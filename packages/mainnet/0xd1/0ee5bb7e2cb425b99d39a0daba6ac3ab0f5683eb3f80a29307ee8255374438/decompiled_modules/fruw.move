module 0xd10ee5bb7e2cb425b99d39a0daba6ac3ab0f5683eb3f80a29307ee8255374438::fruw {
    struct FRUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUW>(arg0, 6, b"FRUW", b"Fruw", b"A poorly drawn frog that seeks love on the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i93dh_Jcf_400x400_fe332e89c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

