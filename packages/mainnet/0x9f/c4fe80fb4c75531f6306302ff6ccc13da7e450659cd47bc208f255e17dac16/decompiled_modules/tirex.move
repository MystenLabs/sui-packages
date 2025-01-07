module 0x9fc4fe80fb4c75531f6306302ff6ccc13da7e450659cd47bc208f255e17dac16::tirex {
    struct TIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIREX>(arg0, 6, b"TIREX", b"Tirex on Sui", b"First Tirex on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fav_8e657d7cbf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

