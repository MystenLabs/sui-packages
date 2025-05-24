module 0x38ad611cdf31583b94110981584af7b93ecf6ea602d81aae2ec5126bec54baee::uc {
    struct UC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UC>(arg0, 9, b"UC", b"UgCoin", b"This ancient digital spirit brings good vibes and moon rocks to the blockchain tribe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e7c0e4a3b9c081f19340f72221acf132blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

