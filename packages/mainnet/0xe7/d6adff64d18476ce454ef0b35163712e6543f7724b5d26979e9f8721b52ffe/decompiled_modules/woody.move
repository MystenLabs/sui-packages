module 0xe7d6adff64d18476ce454ef0b35163712e6543f7724b5d26979e9f8721b52ffe::woody {
    struct WOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODY>(arg0, 6, b"WOODY", b"WoodyDog Sui", b"$WOODY is the most unique and lucky Dog in the Sui Ocean, who remains true to his roots and brings wealth and dynamic energy to the Sui Network. With the lore of the legendary golden Dog, the Dog symbolizes intelligence and ingenuity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001361_5b8e8fcd79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

