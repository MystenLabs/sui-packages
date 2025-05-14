module 0x102b6d0b1ea023077ed31d825b63ee301601eb484bd0b3b6895af06eb4467011::stafisy {
    struct STAFISY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAFISY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAFISY>(arg0, 6, b"STAFISY", b"Stafisy", b"Stafisy dive deep into the sui, where every swim unveils a new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069742_5e335cbc91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAFISY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAFISY>>(v1);
    }

    // decompiled from Move bytecode v6
}

