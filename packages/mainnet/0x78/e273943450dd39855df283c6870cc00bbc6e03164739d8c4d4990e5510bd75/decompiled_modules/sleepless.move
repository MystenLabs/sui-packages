module 0x78e273943450dd39855df283c6870cc00bbc6e03164739d8c4d4990e5510bd75::sleepless {
    struct SLEEPLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEPLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEPLESS>(arg0, 6, b"SLEEPLESS", b"Sleep lesson sui", b"JUST ANOTHER DAY. Three days and nights. Still no sleep! F**k! I'm late. Can't miss the school bus today. Its auditions. Don't rush, you'll get it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidgjtyam6pylrdf6ti7xeape3kocwgwhsoxix66kpztapdfkngnx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEPLESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLEEPLESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

