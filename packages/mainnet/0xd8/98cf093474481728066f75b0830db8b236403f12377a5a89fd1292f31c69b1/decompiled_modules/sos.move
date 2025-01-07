module 0xd898cf093474481728066f75b0830db8b236403f12377a5a89fd1292f31c69b1::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"SwedenObamaSui", b"The freshest meme on SUI is here. SwedenObamaSui. Yes Sui-den can!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030360_8e83da3cb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

