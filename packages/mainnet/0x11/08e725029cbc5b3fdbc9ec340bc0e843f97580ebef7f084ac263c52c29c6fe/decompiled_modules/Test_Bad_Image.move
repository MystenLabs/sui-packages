module 0x1108e725029cbc5b3fdbc9ec340bc0e843f97580ebef7f084ac263c52c29c6fe::Test_Bad_Image {
    struct TEST_BAD_IMAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_BAD_IMAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_BAD_IMAGE>(arg0, 9, b"TBI", b"Test Bad Image", b"this is a bad image", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzSyzmoWMAEcdlX?format=jpg&name=lar")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_BAD_IMAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_BAD_IMAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

