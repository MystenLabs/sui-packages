module 0xba3e0f7e1182803aaec1974988b20697318eb6706bf25a6d99f87deec03dc99f::crabby {
    struct CRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY>(arg0, 6, b"Crabby", b"Crabby Sui Network", b"Crabby by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6052905936219127798_727bcbbdb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

