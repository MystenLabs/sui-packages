module 0x6cb3eccf7ed45425826a6664039b8882fb846e72f943e640078a8e602eba5f5d::dse {
    struct DSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSE>(arg0, 6, b"DSE", b"Dog side eyed", b"wwoof woof wof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_3_08d417373b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

