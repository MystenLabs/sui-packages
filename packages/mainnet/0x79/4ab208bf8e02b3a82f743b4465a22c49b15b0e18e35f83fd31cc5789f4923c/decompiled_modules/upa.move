module 0x794ab208bf8e02b3a82f743b4465a22c49b15b0e18e35f83fd31cc5789f4923c::upa {
    struct UPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPA>(arg0, 6, b"UPA", b"United Pnut of Ameri", b"Squirrels got banks, citizens got $UPA! Join the United Pnut of America and watch your wallet grow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730978870327.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

