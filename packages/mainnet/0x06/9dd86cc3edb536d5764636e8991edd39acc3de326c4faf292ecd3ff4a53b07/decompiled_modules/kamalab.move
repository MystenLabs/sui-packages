module 0x69dd86cc3edb536d5764636e8991edd39acc3de326c4faf292ecd3ff4a53b07::kamalab {
    struct KAMALAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALAB>(arg0, 6, b"Kamalab", b"Kamala Bitch", b"I am bad bitch !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011436_dba2638a58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

