module 0x150da262ae49b7491dbeb3eeeb05adf51be0dd4863ef36af3fa6d3f351191c5e::pnutz {
    struct PNUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTZ>(arg0, 6, b"PNUTZ", b"Pnutz The Degen Squirrel", b"The Revenge of PNUT. From golden acorns to flaming coals PNUT went complete Degen and now he is PNUTZ. Seeking revenge on his father Mark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54345_ee3f6ba303.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

