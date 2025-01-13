module 0x51a17ac382d48301c151718be9bcebcd371788a49538498223f48eeac31a5877::helloworld {
    struct HELLOWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOWORLD>(arg0, 6, b"HELLOWORLD", b"Hello World CTO", b"Hello World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ls_ZES_94k_400x400_6118e6f21e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLOWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

