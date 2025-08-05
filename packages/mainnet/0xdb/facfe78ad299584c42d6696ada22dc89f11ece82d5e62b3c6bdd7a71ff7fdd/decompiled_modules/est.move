module 0xdbfacfe78ad299584c42d6696ada22dc89f11ece82d5e62b3c6bdd7a71ff7fdd::est {
    struct EST has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EST>(arg0, 6, b"EST", b"test", b"fdfdfdfdfdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9728567ccdb5cfe93113b313fe1e8d1_1c4f79c337.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

