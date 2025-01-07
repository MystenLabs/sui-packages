module 0xfc71efe1a80d31f0b8affed5750e35abf4b3fdeea7b0546e13b53bdd255ccfa3::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"Sui Burger", b"Inspired by a viral moment of Trump saying \"crypto burger,\" this token is cooking up something big in the blockchain space. Crypto Burger blends fun, community, and innovation, serving up juicy opportunities for everyone. Join the feast and take a bite of decentralized success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_160641_561bf05951.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

