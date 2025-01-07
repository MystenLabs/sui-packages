module 0x2afb85e186569e77a9550dc7092e0feafd814a0af405a4ff98910d2dcdb86a75::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 6, b"RR", b"Ricochet Rabbit", b"Step into the future of finance with Ricochet Rabbit on SUI, a cryptocurrency inspired by the legendary forest protector and his enduring values of strength, strategy, and resilience. This unique token combines cutting-edge blockchain technology with the adventurous spirit of Ricochet Rabbit, offering both fans and investors a digital asset that stands out in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5860_a24f1d97e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RR>>(v1);
    }

    // decompiled from Move bytecode v6
}

