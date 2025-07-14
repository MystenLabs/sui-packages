module 0x98e4f46fa8defe25b71127fd533cc7d2baad54a3d7049a0e73bbc34330c8faa3::veo3 {
    struct VEO3 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VEO3>, arg1: 0x2::coin::Coin<VEO3>) {
        0x2::coin::burn<VEO3>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<VEO3>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEO3>>(arg0, @0x0);
    }

    fun init(arg0: VEO3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEO3>(arg0, 6, b"VEO3", b"VEO3", b"$VEO3 is a next-generation cryptocurrency designed to empower decentralized ecosystems with a focus on Vision, Evolution, and Opportunity. Built for scalability, community-driven innovation, and real-world utility, VEO3 aims to bridge the gap betwee traditional finance and the decentralized future. WEBSITE - https://veo3coin.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/TFRr3YO.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEO3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEO3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VEO3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VEO3>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

