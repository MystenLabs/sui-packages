module 0x411ab04e81629330d52d28d07353996e155567a6e54b3504236dc4c31f2250e8::psy {
    struct PSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSY>(arg0, 6, b"PSY", b"Psyduck", b"Accidentally launched. Intentionally stupid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4dlzqbh5fguwqnj6lfkktr6rnwvoedwm5ouof2amefu5ot4mi74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

