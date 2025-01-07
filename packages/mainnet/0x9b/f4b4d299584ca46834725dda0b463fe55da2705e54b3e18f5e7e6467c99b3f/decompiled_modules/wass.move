module 0x9bf4b4d299584ca46834725dda0b463fe55da2705e54b3e18f5e7e6467c99b3f::wass {
    struct WASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASS>(arg0, 6, b"WASS", b"wass", b"we are all Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241008_024607_2x_97af5d3682.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

