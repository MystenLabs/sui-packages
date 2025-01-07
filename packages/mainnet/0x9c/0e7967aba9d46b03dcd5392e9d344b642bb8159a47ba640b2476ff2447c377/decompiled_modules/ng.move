module 0x9c0e7967aba9d46b03dcd5392e9d344b642bb8159a47ba640b2476ff2447c377::ng {
    struct NG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NG>(arg0, 9, b"NG", b"tu", b"GOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa4e224d-debb-413b-b196-bc5f1a87d189.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NG>>(v1);
    }

    // decompiled from Move bytecode v6
}

