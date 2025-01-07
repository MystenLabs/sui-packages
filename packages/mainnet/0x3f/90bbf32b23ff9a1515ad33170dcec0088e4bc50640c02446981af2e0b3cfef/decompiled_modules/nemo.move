module 0x3f90bbf32b23ff9a1515ad33170dcec0088e4bc50640c02446981af2e0b3cfef::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"NEMO on Sui", b"Lost and always exploring, NEMO is here to dive deep into the Sui waters. Full of curiosity and a little mischief, this little fish has a big adventure ahead!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nemo_4fa1df10d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

