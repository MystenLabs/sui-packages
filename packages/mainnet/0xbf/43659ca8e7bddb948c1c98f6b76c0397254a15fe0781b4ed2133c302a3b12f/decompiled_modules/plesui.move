module 0xbf43659ca8e7bddb948c1c98f6b76c0397254a15fe0781b4ed2133c302a3b12f::plesui {
    struct PLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLESUI>(arg0, 6, b"PLESUI", b"PLESUISAURUS", b"The plesiosaurus, king of the deep, glides through dark caves, its long neck exploring the depths. A master predator, it hunts in the ancient seas' rich underwater world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dino_5ba32e9a45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

