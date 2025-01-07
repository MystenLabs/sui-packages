module 0x1debd308f1ae5746f6ddf85e5681efd7b686959a6a74c1ce1c6ae14a34ae6e5a::trump2024 {
    struct TRUMP2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2024>(arg0, 6, b"TRUMP2024", b"Mr. President", b"The Original Mr.President token issued to support Donald's Trump Campaign on his way the Battle for the White House. Buying this token will not only support Donald Trump but will also get you future rewards. based on their moonshot contribution. More info coming soon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Uuht00m_400x400_1_d7096b972d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

