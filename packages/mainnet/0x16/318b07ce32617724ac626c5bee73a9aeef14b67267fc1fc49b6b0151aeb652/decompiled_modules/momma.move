module 0x16318b07ce32617724ac626c5bee73a9aeef14b67267fc1fc49b6b0151aeb652::momma {
    struct MOMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMMA>(arg0, 6, b"MOMMA", b"Momma on sui", b"Momma is old and has no strength for endless posts. Momma will go straight to the point because momma cant even walk without her stick.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038986_afb8f0fe02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

