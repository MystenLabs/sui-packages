module 0xd7c836528be64bd0b934f05f9a740e9669079bf8144d999c05bd094aeac8dd9c::liber {
    struct LIBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBER>(arg0, 6, b"Liber", b"Liberland", b"Prime Minister Justin Sun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flag_of_Liberland_svg_c2ca4fa3b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

