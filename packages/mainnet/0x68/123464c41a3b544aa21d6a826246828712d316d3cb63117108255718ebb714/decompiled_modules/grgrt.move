module 0x68123464c41a3b544aa21d6a826246828712d316d3cb63117108255718ebb714::grgrt {
    struct GRGRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRGRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRGRT>(arg0, 9, b"GRGRT", b"Get Rich or Get Rugged Trying", b"Let's get rich!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4da8681b900e355a04616b323dbc5601blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRGRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRGRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

