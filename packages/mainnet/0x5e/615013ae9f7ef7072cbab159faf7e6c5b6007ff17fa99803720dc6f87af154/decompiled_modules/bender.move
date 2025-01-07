module 0x5e615013ae9f7ef7072cbab159faf7e6c5b6007ff17fa99803720dc6f87af154::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 6, b"BENDER", b"SUIBENDER", b"The Last Sui Bender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mascotx_48f3f480b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

