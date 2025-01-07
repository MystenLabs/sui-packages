module 0x642e2ad423907eb5c15e70c3b22c7c95f8e0e55f73f71f93599ed1396c1dd8b6::ampepe {
    struct AMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMPEPE>(arg0, 6, b"AMPEPE", b"Aquaman pepe", b"Conqueror of the Seas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726287655701_4f32937a50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

