module 0x170e8c8fd7334a5510b2d73d4b14cb9bc2503e32d6a06e109e6e5fdef865e6ca::shikoku {
    struct SHIKOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIKOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIKOKU>(arg0, 6, b"Shikoku", b"Shikoku Inu", b"Unique and beautiful. Originated in the mountainous region of Shikoku island. They are medium-sized dogs with pricked ears and curved tails. Shikokus are smart and incredibly independent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Inu_4a3f69e650.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIKOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIKOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

