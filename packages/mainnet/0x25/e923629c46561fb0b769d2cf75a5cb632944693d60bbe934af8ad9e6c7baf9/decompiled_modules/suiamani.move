module 0x25e923629c46561fb0b769d2cf75a5cb632944693d60bbe934af8ad9e6c7baf9::suiamani {
    struct SUIAMANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMANI>(arg0, 6, b"SUIAMANI", b"WORLD PEACE", b"I long for world peace. Recently, most countries and regions are living a miserable life. How many families have been broken down due to war? I hope to stop the war. If you have the conditions and also hope for world peace, please join us. In the future, we will provide assistance to areas in need, reduce PVP, and only need 10 SUI. There is no need to buy too many", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018303_085465003b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

