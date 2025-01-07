module 0x85f2da3770590c9506a6ce1f9c7ce589cb0075b3d8744d0b366bdb8713b01369::mgc {
    struct MGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGC>(arg0, 6, b"MGC", b"Magic3", b"MAgic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_11_16_173230_c280bc74e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

