module 0x8965d0ec7c4b9cf0f0c8d6ccb49194e325f12772dfc9d90f49e77dae144b5ef2::ume {
    struct UME has drop {
        dummy_field: bool,
    }

    fun init(arg0: UME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UME>(arg0, 9, b"Ume", b"Ume On Sui", b"Endangered Malayan tapir calf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcNS599Gj9mB8mzxvsjHk7LyoztK7DifXMitrCXpTrxeK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

