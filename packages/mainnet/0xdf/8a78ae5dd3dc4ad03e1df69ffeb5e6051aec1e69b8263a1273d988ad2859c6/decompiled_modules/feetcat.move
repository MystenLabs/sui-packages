module 0xdf8a78ae5dd3dc4ad03e1df69ffeb5e6051aec1e69b8263a1273d988ad2859c6::feetcat {
    struct FEETCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEETCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEETCAT>(arg0, 6, b"Feetcat", b"Cat on feet", b"Thats just a cat on her feet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6l3tmptmjap91_Photoroom_1x1_dbf38abca3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEETCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEETCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

