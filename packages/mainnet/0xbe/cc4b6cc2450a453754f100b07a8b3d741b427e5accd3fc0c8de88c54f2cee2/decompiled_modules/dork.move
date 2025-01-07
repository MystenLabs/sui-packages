module 0xbecc4b6cc2450a453754f100b07a8b3d741b427e5accd3fc0c8de88c54f2cee2::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"Dork", b"Dork has arrived to shake up the Sui community, bringing a fresh spirit to the world of memecoins with potential ready to skyrocket, supported by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731213980286.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

