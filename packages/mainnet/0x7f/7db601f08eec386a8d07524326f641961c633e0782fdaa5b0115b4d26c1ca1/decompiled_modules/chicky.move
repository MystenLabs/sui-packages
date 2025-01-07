module 0x7f7db601f08eec386a8d07524326f641961c633e0782fdaa5b0115b4d26c1ca1::chicky {
    struct CHICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKY>(arg0, 6, b"CHICKY", b"ChickySUI", x"5355492066756e6e6965737420636869636b656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241201_144144_2_9caac35725.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

