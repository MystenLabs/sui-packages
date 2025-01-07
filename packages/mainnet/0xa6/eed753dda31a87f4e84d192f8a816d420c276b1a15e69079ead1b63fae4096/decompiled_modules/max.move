module 0xa6eed753dda31a87f4e84d192f8a816d420c276b1a15e69079ead1b63fae4096::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 6, b"MAX", b"MAXIMUS", b"Maximus : The toughest cat on $SUI! Fearless, rough, and leading the crypto rebellion. Join the chaos and rise with Maximus! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluelogo_e76b744957.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

