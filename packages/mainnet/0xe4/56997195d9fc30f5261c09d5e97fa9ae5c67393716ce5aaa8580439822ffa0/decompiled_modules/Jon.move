module 0xe456997195d9fc30f5261c09d5e97fa9ae5c67393716ce5aaa8580439822ffa0::Jon {
    struct JON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JON>(arg0, 9, b"JON", b"Jon", b"its a jon life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3589ccd4-20c1-4025-a58d-fad5bbb3bfaf.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

