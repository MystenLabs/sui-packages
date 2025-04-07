module 0x5a77b21bb57fc8d1d537b3a876f665771e03264123594a56a246023f5daeca83::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 9, b"WW", b"walkingwal", b"to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c254622e6c87febb8bd1322a4c5a5321blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

