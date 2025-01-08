module 0xab7a014bc696e06e9904530c0dd2285cff549cc9a428ebe72156c5dee5fb6008::bbf {
    struct BBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBF>(arg0, 6, b"BBF", b"BaBy Fud", b"The Sui ecosystem now rallies behind this unsuspected hero. All he has is his resilient spirit, a blue Sui hat and the support of the whole community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fud_boss_ce4d1b9ded.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBF>>(v1);
    }

    // decompiled from Move bytecode v6
}

