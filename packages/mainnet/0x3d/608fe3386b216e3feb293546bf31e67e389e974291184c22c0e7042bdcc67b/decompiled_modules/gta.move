module 0x3d608fe3386b216e3feb293546bf31e67e389e974291184c22c0e7042bdcc67b::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 6, b"GTA", b"Gta", b"The Ticker is $GTA - Grand Theft Alpha - Verify your Token Holdings in our Discord to Access our Alpha Ecosystem and upcoming Games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gta_62a3b66139.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

