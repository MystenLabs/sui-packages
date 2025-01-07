module 0x79512ca9315e3e510841b964d1c0b4c4962026e88b4805585f0cb27cd1346983::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 3, b"TEST", b"TEST", b"TEST is a coin for the TEST project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d7cFZXt/portomasonet.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

