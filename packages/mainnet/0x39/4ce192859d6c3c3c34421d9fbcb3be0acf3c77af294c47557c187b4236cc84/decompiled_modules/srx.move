module 0x394ce192859d6c3c3c34421d9fbcb3be0acf3c77af294c47557c187b4236cc84::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 6, b"Srx", b"Suirex", b"We are at movepump because hopfun has been postponed again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051361_21ffc2e6cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

