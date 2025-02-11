module 0x6a1e0ce087f51bd8fa41459b47c72a37a29d26caf74b863a4bb23b33523996db::help {
    struct HELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELP>(arg0, 6, b"HELP", b"I Live In Car", b"I am a 32 year olf father of 2 boys. I have a wife and thankfully they are staying with my in laws. they happen to have a 1 bed room apt though . I was evicted by my own blood relatives. This comes after the loss of my mother and other love ones...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739278373566.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

