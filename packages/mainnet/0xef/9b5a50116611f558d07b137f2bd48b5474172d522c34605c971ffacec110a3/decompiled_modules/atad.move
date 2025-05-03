module 0xef9b5a50116611f558d07b137f2bd48b5474172d522c34605c971ffacec110a3::atad {
    struct ATAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATAD>(arg0, 6, b"ATAD", b"Amazing Tron Address", b"$ATAD is used to purchase Amazing Tron Address like TXRLsWhEQzUopbJnSvfjM5NujP99999999.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ATAD_a093c05319.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

