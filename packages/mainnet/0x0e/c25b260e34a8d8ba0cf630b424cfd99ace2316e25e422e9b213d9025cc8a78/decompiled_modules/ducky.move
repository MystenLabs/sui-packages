module 0xec25b260e34a8d8ba0cf630b424cfd99ace2316e25e422e9b213d9025cc8a78::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"Ducky", b"DuckyCity", b"Welcome to DuckyCity, where fantasy meets reality. Immerse yourself in this revolutionary #dapp that combines Gamefi, Metaverse and Socialfi. Connect boundlessly, earn endlessly, and make the virtual world your oyster! Join us now on this incredible journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1221728832918_pic_8a7f4735f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

