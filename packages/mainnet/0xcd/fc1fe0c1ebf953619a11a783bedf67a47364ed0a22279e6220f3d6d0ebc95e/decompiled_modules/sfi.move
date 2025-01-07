module 0xcdfc1fe0c1ebf953619a11a783bedf67a47364ed0a22279e6220f3d6d0ebc95e::sfi {
    struct SFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFI>(arg0, 9, b"SFI", b"SuiFi", b"SuiFi (SFI) is a DeFi token on the Sui blockchain, focused on enhancing scalability, efficiency, and transparency in decentralized finance transactions and liquidity solutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1619967769549877248/y1kjJ2J7.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFI>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

