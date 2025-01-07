module 0xe11c800efff7faa1daa7fac42ad4ebc358967fcff46031bd8701ae8d6604b2cb::get {
    struct GET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GET>(arg0, 9, b"GET", b"Gaint Elephant ", b"Fair launch Gaint Elephant token on Sui Network  LP has been burned and sent to the burn wallet. Trust no one check it now before you buy GET. LEGIT TOKEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/whGvC40")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GET>(&mut v2, 9500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GET>>(v1);
    }

    // decompiled from Move bytecode v6
}

