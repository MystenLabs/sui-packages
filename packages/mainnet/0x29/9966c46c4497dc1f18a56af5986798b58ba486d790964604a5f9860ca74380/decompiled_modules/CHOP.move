module 0x299966c46c4497dc1f18a56af5986798b58ba486d790964604a5f9860ca74380::CHOP {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 9, b"ChopSui", b"Chop Sui Token", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/CHOPSUI_5db8e786a3.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOP>>(0x2::coin::mint<CHOP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHOP>>(v2);
    }

    // decompiled from Move bytecode v6
}

