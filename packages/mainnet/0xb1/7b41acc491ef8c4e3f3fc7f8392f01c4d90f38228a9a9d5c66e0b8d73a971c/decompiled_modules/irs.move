module 0xb17b41acc491ef8c4e3f3fc7f8392f01c4d90f38228a9a9d5c66e0b8d73a971c::irs {
    struct IRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRS>(arg0, 6, b"IRS", b"$IRS | iridescent rabbit shark CTO", b"I am the Iridescent Rabbit Shark, and there is only one of me.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_14_09_00_3049709ec3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

