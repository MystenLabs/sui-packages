module 0x97e1ffd83d5dc1078c896627178197e6be21464f619d5c555f4ad12b30cb43ee::polpix {
    struct POLPIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLPIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLPIX>(arg0, 6, b"POLPIX", b"Polar Pixel Sui", b"Best Polar Bear Pixel Community on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12121212_f1e309bb37.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLPIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLPIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

