module 0xe3cfaa087aef4e882080cc82e3c57aff59fa08b431d37d7c239ef96da9e2ed27::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Performance AI", b"Science dictates that the mysterious and intelligent Octopus was brought to earth on a meteorite. Alien co-inhabitors of our world. OctopuSUI was brought to SUI by another friendly alien species.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736212221609_1_768c74fca5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

