module 0x8a3141e3fd8b243ad866cd48b237f6b7cd973d48dcae0737393dcedd2613838d::moonbags {
    struct MOONBAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBAGS>(arg0, 6, b"Moonbags", b"MoonBags Official", b"Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreib6pcmduiuug6yipr4ljooa3rebmprbvxgj3f6t3vyp3sx7cau25a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBAGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONBAGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

