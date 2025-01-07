module 0x98595e19279655efa6b7cd572dd391251e49c5d94d170680ef318b7fb5802e93::wiggmax {
    struct WIGGMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGMAX>(arg0, 6, b"WIGGMAX", b"WIGGERMAXXED", b"are you even wiggermaxxing bro?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_174151_356_af299929b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

