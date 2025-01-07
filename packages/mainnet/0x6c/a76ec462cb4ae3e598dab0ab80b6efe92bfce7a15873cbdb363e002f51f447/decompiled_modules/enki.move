module 0x6ca76ec462cb4ae3e598dab0ab80b6efe92bfce7a15873cbdb363e002f51f447::enki {
    struct ENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENKI>(arg0, 6, b"ENKI", b"Enki On Sui", b"Enki - Greetings Im Enki on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018074_f34f3c394e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

