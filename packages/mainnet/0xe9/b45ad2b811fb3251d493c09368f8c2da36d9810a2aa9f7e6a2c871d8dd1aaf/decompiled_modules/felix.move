module 0xe9b45ad2b811fb3251d493c09368f8c2da36d9810a2aa9f7e6a2c871d8dd1aaf::felix {
    struct FELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELIX>(arg0, 6, b"Felix", b"Felix The Sui Cat", b"Your Felix the sui cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Felix_the_Cat_TV_series_title_7e783e9d90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FELIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

