module 0x44128b7ee80eb994079a458d3951bbbd1f90729b01527a2924c80d750bf51489::lami {
    struct LAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMI>(arg0, 6, b"LAMI", b"LAMI THE KITTY", b"Lami is the mischievous kitty on Sui. With Lami, we are aiming to build something different on Sui. The timeline is stacked up with a lot of chaos upcoming, grab a bag, sit tight and ride the waves of the Suinami with us. Lami isnt a game, holders wont get a claim.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_19_51_34_4195cd8e38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

