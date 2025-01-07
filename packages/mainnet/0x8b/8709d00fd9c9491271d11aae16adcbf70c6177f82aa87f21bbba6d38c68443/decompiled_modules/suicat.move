module 0x8b8709d00fd9c9491271d11aae16adcbf70c6177f82aa87f21bbba6d38c68443::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Sui Cat", b"A community of cats swimming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000456907_d5bfa6ef9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

