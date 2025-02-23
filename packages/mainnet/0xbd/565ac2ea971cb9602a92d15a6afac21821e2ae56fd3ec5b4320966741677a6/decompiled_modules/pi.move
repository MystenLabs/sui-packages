module 0xbd565ac2ea971cb9602a92d15a6afac21821e2ae56fd3ec5b4320966741677a6::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 6, b"PI", b"Pi Network", b"Pi is a new digital currency. This app allows you to access and grow your Pi holdings and serves as wallet to host your digital assets. Pi is distributed, eco - friendly and consumes minimal battery power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/8d731268-de41-42c7-9132-7836a2be7c4b.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

