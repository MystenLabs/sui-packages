module 0xdcfcef24e685fc32cd19556df6b8aaa9d9081db7288fa165ac96c05ba7d886c4::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"Ducky", b"Ducky Token", b"Welcome to DuckyCity, where fantasy meets reality. Immerse yourself in this revolutionary #dapp that combines Gamefi, Metaverse and Socialfi. Connect boundlessly, earn endlessly, and make the virtual world your oyster! Join us now on this incredible journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1221728832918_pic_2a9c357551.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

