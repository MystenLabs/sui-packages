module 0x2214d59813f27e9bde8c6af05cf8954416b5415cadc28e962e66b97dfe73740b::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"ADA token", b"ADA on AkaSui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/96bcf35e-7eb8-4308-8625-9bb13fb38670.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

