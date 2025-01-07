module 0xe4ff38c4eda61f9b7e02a73dd6af5cd50ab81390743434801e48d8a068a502d2::pumpy {
    struct PUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPY>(arg0, 9, b"PUMPY", b"Pumpy Cat", b"Sui Mascot Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834177045066076160/CAPtmkms_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

