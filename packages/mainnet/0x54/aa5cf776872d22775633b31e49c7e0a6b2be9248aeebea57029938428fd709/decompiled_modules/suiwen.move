module 0x54aa5cf776872d22775633b31e49c7e0a6b2be9248aeebea57029938428fd709::suiwen {
    struct SUIWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEN>(arg0, 6, b"SuiWEN", b"WEN", b"We split @weremeows poem 'A Love Letter to Wen Bros' into a trillion pieces that trade like normal Sui tokens. Each Wen token equals proportional ownership in Meow's poem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24_028db759f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

