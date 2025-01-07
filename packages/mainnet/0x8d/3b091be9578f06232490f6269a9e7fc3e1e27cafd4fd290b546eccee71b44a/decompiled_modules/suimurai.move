module 0x8d3b091be9578f06232490f6269a9e7fc3e1e27cafd4fd290b546eccee71b44a::suimurai {
    struct SUIMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAI>(arg0, 6, b"Suimurai", b"Suimurai Cat", b"In the world of Suimurai, only the bold win big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Murai_Cat_2_ae372521bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

