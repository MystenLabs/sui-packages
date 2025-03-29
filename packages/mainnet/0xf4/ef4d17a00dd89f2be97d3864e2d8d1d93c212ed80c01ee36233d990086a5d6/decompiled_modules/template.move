module 0xf4ef4d17a00dd89f2be97d3864e2d8d1d93c212ed80c01ee36233d990086a5d6::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"TOM", b"Tomified", x"47657420726561647920746f206d65657420544f4d2c20746865206b696e67206f66206d656d6520636f696e732120426f726e2066726f6d2074686520737069726974206f6620636f6d6d756e69747920616e642064726976656e20627920707572652066756e2c20544f4d206973206865726520746f2072756c6520746865206d656d6520756e6976657273652e205768657468657220796f75e28099726520612063727970746f20656e7468757369617374206f72206a757374206c6f7665206d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jurassiq-bucket.s3.eu-north-1.amazonaws.com/2cbd921af036f6affea5089e294c2165.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

