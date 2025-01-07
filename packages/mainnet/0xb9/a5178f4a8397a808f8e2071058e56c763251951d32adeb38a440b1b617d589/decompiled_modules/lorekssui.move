module 0xb9a5178f4a8397a808f8e2071058e56c763251951d32adeb38a440b1b617d589::lorekssui {
    struct LOREKSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOREKSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOREKSSUI>(arg0, 6, b"LOREKSSUI", b"LOREKS", b"$LOREKS is a meme project inspired by the iconic Rolex brand. While Rolex price face volatility, $LOREKS presents a stable and promising alternative, offering investors steady growth and exciting utilities such as a gambling platform and staking opportunities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000216362_29540796b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOREKSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOREKSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

