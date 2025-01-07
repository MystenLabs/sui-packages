module 0x603a5c66c369374d49fc8831f92c6ab6cdcca26ddb2d18276ca86fb10faf2331::aievan {
    struct AIEVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIEVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIEVAN>(arg0, 6, b"AIEVAN", b"The first AI Evan on SUI", b"AI generation showed how beautiful Evan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9280_f35e9fe0c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIEVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIEVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

