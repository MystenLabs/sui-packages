module 0xd0cb9cc02b8e35985c874b29bdd4162867b38ae8e66d4f8d9f3274795d53be1a::temple {
    struct TEMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLE>(arg0, 6, b"Temple", b"temple", b"Temples are a kind of religion. The religious culture originated from Tang Monk's journey to the West to seek Buddhist scriptures and was introduced to China. It has a religious sect with many people in the world. In the future, practical applications will be developed to pray to gods and Buddhas and consume tokens to obtain the protection of gods.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730710229363_83a32d2e49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

