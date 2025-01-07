module 0xa4580eb852858911d9d01b1e6a9cca9bc86f2771367b6cc70ee81da823a14a5d::lui {
    struct LUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUI>(arg0, 6, b"LUI", b"Louie", b"Louie is Sui's #1 dog - mastering the art of attention, one paw at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/louie_40013817b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

