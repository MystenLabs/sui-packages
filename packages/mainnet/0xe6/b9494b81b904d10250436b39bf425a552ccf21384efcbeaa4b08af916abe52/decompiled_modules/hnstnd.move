module 0xe6b9494b81b904d10250436b39bf425a552ccf21384efcbeaa4b08af916abe52::hnstnd {
    struct HNSTND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNSTND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNSTND>(arg0, 6, b"HNSTND", b"Handstand Dog", b"Look! He's doing a handstand!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/handstand_dog_53c0368b9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNSTND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNSTND>>(v1);
    }

    // decompiled from Move bytecode v6
}

