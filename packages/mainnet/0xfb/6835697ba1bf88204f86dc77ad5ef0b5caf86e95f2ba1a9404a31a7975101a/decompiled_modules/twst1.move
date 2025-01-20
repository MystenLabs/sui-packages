module 0xfb6835697ba1bf88204f86dc77ad5ef0b5caf86e95f2ba1a9404a31a7975101a::twst1 {
    struct TWST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWST1>(arg0, 9, b"Twst1", b"test", b"twst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6f8797265473efd3a4d760341b8bca5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

