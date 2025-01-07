module 0xf59f94ef3635eb35469ae59665a5ace53b1f41e2c7e6199ed5bc3e001cf8d1b5::vote {
    struct VOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOTE>(arg0, 9, b"Vote", b"Voted", b"Have u voted yet?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2136ac001c91bea85bfeb7307e9aad5dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

