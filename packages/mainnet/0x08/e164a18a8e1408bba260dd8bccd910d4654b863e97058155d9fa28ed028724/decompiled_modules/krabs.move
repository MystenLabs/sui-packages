module 0x8e164a18a8e1408bba260dd8bccd910d4654b863e97058155d9fa28ed028724::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 6, b"KRABS", b"MrKrabs", x"504f432e0a446f6e2774206275792c2069742773206a757374206120746573740a446f6e2774206275792c2049276d206a757374207465616368696e6720736f6d657468696e6720746f206120667269656e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a376e1891971a152b164b9e9689820e6_e189642709.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

