module 0x8a8e8f8da889b1a0445e7815e038f04d8f5b29fc80fd5e1d63558a65bd0ceb79::pra {
    struct PRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRA>(arg0, 6, b"PRA", b"Prabowo", b"Prabowo Subianto Djojohadikusumo is a politician, businessman, and retired TNI general who currently serves as Indonesia's eighth president since October 20, 2024. Previously he served as the 26th Minister of Defense", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_b2c4f22a37.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

