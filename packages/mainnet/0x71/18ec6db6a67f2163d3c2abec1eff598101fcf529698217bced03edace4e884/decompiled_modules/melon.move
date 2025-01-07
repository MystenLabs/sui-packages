module 0x7118ec6db6a67f2163d3c2abec1eff598101fcf529698217bced03edace4e884::melon {
    struct MELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELON>(arg0, 6, b"MELON", b"hippo eats watermelon", b"Hippo loves watermelon. Its funny token , DYOR. i will not run this. just i like this idea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kr3t62k6tktjkhieab5x3rclz2ff_99b9cec0b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

