module 0x94180ff21f256e2ad6a08e3b324edc84979cdc5a162bc09087a4217612466aca::nuki {
    struct NUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKI>(arg0, 6, b"NUKI", b"Tanuki", b"Built by the Tanuki Crypto Community for it's members. NUKI Coin is designed to create engagement, participation and rewards with in the community. TheTanuki.xyz for more information or follow us on X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nuki_eab1a9cc9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

