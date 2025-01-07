module 0xb6a2dc0ec92301b586a4ff00b1a8530dd2e327e9cfeae3f6007d811ea765e0f::jad {
    struct JAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAD>(arg0, 6, b"JAD", b"JAMES A DONALD", b"Introducing $JAD (James A. Donald), the revolutionary memecoin that claims to unveil the true identity of Satoshi Nakamoto! Inspired by the enigmatic figure behind Bitcoin, $JAD combines humor and mystery, inviting the community to join the quest for blockchain enlightenment. With a playful spirit and a vision for decentralization, $JAD aims to empower users and celebrate the legacy of cryptocurrency. Dive into the funget your JAD today and become part of the legend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003135_8c6ab7bce7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

