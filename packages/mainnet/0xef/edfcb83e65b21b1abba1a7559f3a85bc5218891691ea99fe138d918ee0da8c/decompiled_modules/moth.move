module 0xefedfcb83e65b21b1abba1a7559f3a85bc5218891691ea99fe138d918ee0da8c::moth {
    struct MOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTH>(arg0, 6, b"MOTH", b"FIRST MOTH ON SUI", b"$MOTH comes to the bright lights of SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme2_ae1218a168.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

