module 0xc6ac767c3722fc9c260f150e651af5cd8b7cb634e5c2272604ab169b5f6ec108::War {
    struct WAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR>(arg0, 9, b"WAR", b"War", b"fight for the right reasons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/31af7061-06d5-4119-b79d-68aa155de25a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

