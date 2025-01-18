module 0xac3f58fd9059102b1c2a28da42663da1739a20ad4aaa4851db95112dca633f72::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"Blui", b"Blui on Sui", b"Dive into the vibrant world of Blui, the blue koala-inspired cryptocurrency on the Sui blockchain. Blui Coin combines the charm of its adorable mascot with the cutting-edge technology of Sui, offering a unique and engaging digital asset experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737170385977.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

