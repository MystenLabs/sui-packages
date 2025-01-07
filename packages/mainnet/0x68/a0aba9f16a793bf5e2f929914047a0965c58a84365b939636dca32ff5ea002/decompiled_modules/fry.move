module 0x68a0aba9f16a793bf5e2f929914047a0965c58a84365b939636dca32ff5ea002::fry {
    struct FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRY>(arg0, 6, b"FRY", b"SUIFY", b" SuiFry is frying up something crispy on the blockchain!  Coming soon to SUI. Be cautiousonly trust our official posts. Get ready for takeoff! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LAUNCH_SUIFRY_1_4b59167aa1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

