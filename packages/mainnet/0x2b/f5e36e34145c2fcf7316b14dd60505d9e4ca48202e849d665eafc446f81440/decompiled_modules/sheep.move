module 0x2bf5e36e34145c2fcf7316b14dd60505d9e4ca48202e849d665eafc446f81440::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 6, b"SHEEP", b"SUI Sheep", b"suisheep.xyz . BLUE LIKE SUI AND WHITE LIKE CLOUDS WITH $SHEEP SKY IS THE LIMIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11111_b8b98c68f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

