module 0x5c630e728be15192cf94dbdc7e7313284de4aa15ec251c8ea922ede5d1ab4751::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG>(arg0, 9, b"STG", b"STRATAGEY", b"THE MOST IMPORTANT TO WIN IS STRATAGEY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad9eed40-86c1-4ab9-9236-475264a89af7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG>>(v1);
    }

    // decompiled from Move bytecode v6
}

