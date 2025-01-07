module 0x6e04c9281c825d6303686b93dcd20a65e8258c859eff94fd7fa8b454c715634b::pawsun {
    struct PAWSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWSUN>(arg0, 6, b"PAWSUN", b"Sui Pawsun", b"The purr-fect blend of charm and crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014932_43454eda99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

