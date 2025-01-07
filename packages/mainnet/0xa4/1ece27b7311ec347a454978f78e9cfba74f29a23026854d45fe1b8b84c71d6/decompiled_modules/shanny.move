module 0xa41ece27b7311ec347a454978f78e9cfba74f29a23026854d45fe1b8b84c71d6::shanny {
    struct SHANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHANNY>(arg0, 6, b"SHANNY", b"Shanny The Sheep", b"Fluffy, fearless and fighting for free, fres grash, advocate for better pastures and bold opinions on politics & economics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020692_dd5beb6f89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHANNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

