module 0xa38f93e19a8e57ed4643888e0e58b8215de42c5985a6d6b83f0b78584cca9382::suitoonsuii {
    struct SUITOONSUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOONSUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOONSUII>(arg0, 6, b"Suitoonsuii", b"Suitoonsui", b"Suitoon sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906511_2e8f26fea5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOONSUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOONSUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

