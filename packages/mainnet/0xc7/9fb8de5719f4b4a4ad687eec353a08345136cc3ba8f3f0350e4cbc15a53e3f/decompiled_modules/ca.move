module 0xc79fb8de5719f4b4a4ad687eec353a08345136cc3ba8f3f0350e4cbc15a53e3f::ca {
    struct CA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA>(arg0, 9, b"CA", b"Cher Ami", b"Cher Ami (French for \"dear friend\", in the masculine) was a male[a] homing pigeon known for his military service during World War I, especially the Meuse-Argonne offensive in October 1918. According to popular legend he delivered a message alerting America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA>>(v2, @0xf8dd0eacada357e7107a70633ad236c1bea1dcf24a539d15f7263ad29db0e2b7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CA>>(v1);
    }

    // decompiled from Move bytecode v6
}

