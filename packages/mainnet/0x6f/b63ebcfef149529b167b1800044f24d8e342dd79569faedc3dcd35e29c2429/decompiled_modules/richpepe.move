module 0x6fb63ebcfef149529b167b1800044f24d8e342dd79569faedc3dcd35e29c2429::richpepe {
    struct RICHPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHPEPE>(arg0, 6, b"RICHPEPE", b"RichPepe", b"RichPepe: From pond to penthouse!  This dapper frog in a tuxedo turned Sui magic into pure class. Now he's just chillin', serving rare pepe energy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tuxedo_c649a63f20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

