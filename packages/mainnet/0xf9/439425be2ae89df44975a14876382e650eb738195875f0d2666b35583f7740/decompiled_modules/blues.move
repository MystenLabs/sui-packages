module 0xf9439425be2ae89df44975a14876382e650eb738195875f0d2666b35583f7740::blues {
    struct BLUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUES>(arg0, 6, b"BLUES", b"Blues coin", b"Supporting pet shelters & rescues via a charity meme coin. Community votes, transparent donations, & updates. 12 charities in 1 year.  #CryptoForGood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053407_dc35566118.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUES>>(v1);
    }

    // decompiled from Move bytecode v6
}

