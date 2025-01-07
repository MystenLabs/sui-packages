module 0xeb35e1988d21721323deb590dae3fed10a78d55a4cbbbf15cdb501e3799ae131::devil {
    struct DEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVIL>(arg0, 6, b"Devil", b"Sui Devil", x"5468652074727565204576696c206f66205375692e20426f6c642c2072656c656e746c6573732c20616e64206865726520746f20646f6d696e6174652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Devil_103e7cbcb5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

