module 0x471b74424e602f632d150f42e0b8a5a80da400c2db4930fbac34abfdec0f328e::meotercat {
    struct MEOTERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOTERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOTERCAT>(arg0, 6, b"MEOTERCAT", b"Meoter Cat Sui", b"Meoter Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/favicon_9e56728e41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOTERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOTERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

