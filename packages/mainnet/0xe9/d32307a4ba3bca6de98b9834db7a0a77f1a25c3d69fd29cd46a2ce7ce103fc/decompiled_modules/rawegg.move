module 0xe9d32307a4ba3bca6de98b9834db7a0a77f1a25c3d69fd29cd46a2ce7ce103fc::rawegg {
    struct RAWEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAWEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAWEGG>(arg0, 6, b"RAWEGG", b"Sui Rawegg", b"Let's cooking me!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016540_3395d777df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAWEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAWEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

