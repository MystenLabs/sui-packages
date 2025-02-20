module 0x90c5b2ccb0d59198d202df8315bc5607e18df4e2ba371d57c87988800e919300::ip {
    struct IP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IP>(arg0, 0, b"IP", b"Story", b"Created Story With Low MC . Best opportunity for investors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/nq2yhk3Q/Transparent-bg.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IP>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IP>>(v1);
    }

    // decompiled from Move bytecode v6
}

