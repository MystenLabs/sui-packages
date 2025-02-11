module 0xd74adf57fd33430768006534f7ee8704f5c797213208a30e8e0d0149bc631db7::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 6, b"TORO", b"Toro The Bull", b"TORO is the bold and dynamic mascot of SUI, symbolizing strength, growth, and unity in the world of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007621_cfee2981e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

