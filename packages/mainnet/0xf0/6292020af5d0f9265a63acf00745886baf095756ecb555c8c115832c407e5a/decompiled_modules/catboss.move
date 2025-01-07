module 0xf06292020af5d0f9265a63acf00745886baf095756ecb555c8c115832c407e5a::catboss {
    struct CATBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSS>(arg0, 6, b"CatBoss", b"cat", b"Build the cat boss together and rush to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012748_48ad6f21ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

