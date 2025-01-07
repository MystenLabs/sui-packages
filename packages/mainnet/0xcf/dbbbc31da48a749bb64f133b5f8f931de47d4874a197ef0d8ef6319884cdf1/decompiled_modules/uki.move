module 0xcfdbbbc31da48a749bb64f133b5f8f931de47d4874a197ef0d8ef6319884cdf1::uki {
    struct UKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UKI>(arg0, 9, b"UKI", b"Suki", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UKI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

