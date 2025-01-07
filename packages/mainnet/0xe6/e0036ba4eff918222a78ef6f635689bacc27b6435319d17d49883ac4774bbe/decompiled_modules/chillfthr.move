module 0xe6e0036ba4eff918222a78ef6f635689bacc27b6435319d17d49883ac4774bbe::chillfthr {
    struct CHILLFTHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFTHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFTHR>(arg0, 6, b"CHILLFTHR", b"A chill father", x"41206368696c6c2066617468657220284348494c4c46544852290a4368696c6c4661746865722077616e747320686973206d6f6e65792e20497427732074696d6520746f20706179207570", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/124124_f8c2dc20f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFTHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFTHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

