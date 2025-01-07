module 0xd4026bc9e28b3149fcccabf32b7752b21ccb92b5c721deea767b9bca65400756::owly {
    struct OWLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLY>(arg0, 6, b"OWLY", b"Matt Furie s OWLY", b"$OWLY by MATT FURIE One of 1,000 Hedz. Hand drawn by Matt Furie on planet Earth in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114541_29bf305305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

