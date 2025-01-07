module 0x6af33e70b2cf2a7477969ceb2e534d73f35d6d921431e8ef1dffc3a82fd77b05::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"LION", b"Lion Turbo Coin", b"Lion Turbo is your ultimate defense in crypto, standing against scams, fraud, and rug pulls. Were not just another tokenwere here to protect your investments. Together, we will surpass challenges and create a safer, transparent crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726504817024_08c90fd7cf972be8e399475d7a4786ae_9c4939ee37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v1);
    }

    // decompiled from Move bytecode v6
}

