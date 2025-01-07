module 0xba55b46e1612c35ce72d0a5f1c037a6a1634f15c446ae850392cf62822e6630::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"WIZARD", b"Sui Wizard", b"Master of water magic on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_2_59f2384409.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

