module 0x46d5a776acf77e778632ece717c9997c225d09ffe96c9042234749a9c03ff50d::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"Puggy Dog", x"4974277320706f6973656420746f206d616b65207761766573206f6e20537569204e6574776f726b2063757a206d6f7374206472697070696e2720646f6720676f6e6e61207374657020696e746f206974200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9646_f3bd608bde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

