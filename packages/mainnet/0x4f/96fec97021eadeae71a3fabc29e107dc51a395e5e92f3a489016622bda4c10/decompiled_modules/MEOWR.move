module 0x4f96fec97021eadeae71a3fabc29e107dc51a395e5e92f3a489016622bda4c10::MEOWR {
    struct MEOWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWR>(arg0, 6, b"Purr Royale", b"MEOWR", b"A meme coin for the ultimate feline showdown! Join the battle royale where cats claw their way to the top. Only the strongest, fluffiest, and most mischievous will survive. Will your cat be the last one purring?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/BzLFLtF7Dw4VKRPerfk8kbf0BcZ3kQU6JCFUk24nzofe57voC/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWR>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

