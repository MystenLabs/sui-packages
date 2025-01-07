module 0xec0cd4f82976dc62681e0bf88085b9b1e19689b462e4507283dfad289d0e27fe::sdc {
    struct SDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDC>(arg0, 9, b"SDC", b"SOLDIERCAT", b"A soldier cat meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94f55aca-07db-4378-a46f-57024420e7d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

