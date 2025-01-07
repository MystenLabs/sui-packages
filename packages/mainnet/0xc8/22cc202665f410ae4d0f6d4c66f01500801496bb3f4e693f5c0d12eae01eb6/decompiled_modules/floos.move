module 0xc822cc202665f410ae4d0f6d4c66f01500801496bb3f4e693f5c0d12eae01eb6::floos {
    struct FLOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOOS>(arg0, 6, b"FLOOS", b"floos", b"FLOOS is a memecoin Aiming to promote Arab culture properly, and reduce cultural and cognitive differences between Eastern and Western communities. The project has been planned for months. We will reveal more details later, but it is supported by one of the strongest Arab communities in web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240921100209_fc8d93babe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

