module 0x21d3150977fdb56d624bce68c678ded4b25c3439dc994546bb4b9826e59abb24::knc {
    struct KNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNC>(arg0, 6, b"KNC", b"KaniCoin", b"Everyone loves crabs! They're cute and funny!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1777262436433.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

