module 0x2d5a21db90a1bfbb5888ca1d4aee3005aaf33bd93414d52a12b12f47ed1fec56::bow {
    struct BOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOW>(arg0, 6, b"BOW", b"Bo'ohw'o'wo'er", b"Bo'ohw'o'wo'er is a playful project about the British way of saying \"bottle of water.\" It brings humor to how British accents become a funny topic wherever they go. Built on the Sui Network, this project turns a simple phrase into a way for people to connect and share laughs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007480_7065ee03c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

