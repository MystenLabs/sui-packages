module 0x12f9247246a8160fc5703e62f0a4ef04e03f4fcd78466d657fc1ade1c1ad4e1b::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"GAY", b"Gay Fish", x"47617920576573742c206c65742773207377696d20616761696e7374207468652063757272656e742c206461726c696e672e205468657265277320616c7761797320726f6f6d20696e207468652073656120666f72206120666162756c6f757320676179206669736821200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logogay_38e3024a8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

