module 0xc4cbfa6fb18eb9f02d8f4d29ff4d43ee4b7f3e222d689c9c66eabe83f44ba49::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 9, b"Rakki", b"RaKkI CaT", b"Introducing $Rakki Cat: a meme coin inspired by Japan's \"maneki-neko,\" symbolizing luck and prosperity. Built on the Sui Network, $Rakki Cat blends playful charm with real community-driven potential. Whether you're a crypto veteran or newcomer,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Frr_3cfde6438d.jpg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAKKI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

