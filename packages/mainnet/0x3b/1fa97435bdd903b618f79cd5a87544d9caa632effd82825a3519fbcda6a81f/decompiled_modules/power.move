module 0x3b1fa97435bdd903b618f79cd5a87544d9caa632effd82825a3519fbcda6a81f::power {
    struct POWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWER>(arg0, 6, b"POWER", b"Power Dog", b"Power dog is The golden retrievier that will lead the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022248_d2e9595428.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

