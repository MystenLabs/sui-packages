module 0x279c278c0354c33d8de2e43eba19cffc0ce47d087cc65b15f921e9981c4f59ee::w3 {
    struct W3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W3>(arg0, 6, b"W3", b"Web3 Blog", b"https://app.towns.com/t/0x823a9db7a75161d4eb70ecfc495a8f28f9c140a5/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6652_de6c8c84fd.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W3>>(v1);
    }

    // decompiled from Move bytecode v6
}

