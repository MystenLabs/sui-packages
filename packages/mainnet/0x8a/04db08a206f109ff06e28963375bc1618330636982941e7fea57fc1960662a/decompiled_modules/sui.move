module 0x8a04db08a206f109ff06e28963375bc1618330636982941e7fea57fc1960662a::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Sui-Kun", b"He has a fearless personality, loves to play, and has plenty of energy. He's a bit of a spoiled brat, and before you know it, he's sleeping next to you. He eats well, plays well, and is very energetic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikun_c864811154.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

