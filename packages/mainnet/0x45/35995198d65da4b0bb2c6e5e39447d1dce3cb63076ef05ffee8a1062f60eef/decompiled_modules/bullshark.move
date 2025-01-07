module 0x4535995198d65da4b0bb2c6e5e39447d1dce3cb63076ef05ffee8a1062f60eef::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSHARK>(arg0, 6, b"BULLSHARK", b"The BullShark", b"The most beloved and well-known Suifrien, created by Mysten Labs, is now ready to guide you through an ocean of opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XZ_Lwqlj_H_400x400_fbbebd1de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

