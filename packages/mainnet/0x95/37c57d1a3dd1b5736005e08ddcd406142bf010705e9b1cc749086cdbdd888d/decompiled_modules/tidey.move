module 0x9537c57d1a3dd1b5736005e08ddcd406142bf010705e9b1cc749086cdbdd888d::tidey {
    struct TIDEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDEY>(arg0, 6, b"Tidey", b"TIDEY", b"$TIDEY is a legendary underwater creature that protects the entire ecosystem in the SUI world. $TIDEY can transform into anything, and like a ghost, he can also be invisible. The tidal waves that are pumped indicate his presence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tidey_cd3d1fa6f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIDEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

