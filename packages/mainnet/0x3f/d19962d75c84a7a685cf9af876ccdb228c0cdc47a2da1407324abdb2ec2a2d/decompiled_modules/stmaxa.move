module 0x3fd19962d75c84a7a685cf9af876ccdb228c0cdc47a2da1407324abdb2ec2a2d::stmaxa {
    struct STMAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXA>(arg0, 9, b"STMAXA", b"Stmax", b"Stma----SSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93c65ad2-4f10-412a-bd5b-42e1fad5107d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

