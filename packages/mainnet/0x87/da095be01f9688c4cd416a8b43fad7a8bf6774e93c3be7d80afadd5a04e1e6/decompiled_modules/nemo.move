module 0x87da095be01f9688c4cd416a8b43fad7a8bf6774e93c3be7d80afadd5a04e1e6::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"Nemo on Sui", b"Lost and always exploring, $NEMO is here to dive deep into the Sui waters. Full of curiosity and a little mischief, this little fish has a big adventure ahead! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_8be55c5851.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

