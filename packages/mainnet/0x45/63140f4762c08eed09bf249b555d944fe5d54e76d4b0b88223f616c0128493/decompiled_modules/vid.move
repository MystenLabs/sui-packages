module 0x4563140f4762c08eed09bf249b555d944fe5d54e76d4b0b88223f616c0128493::vid {
    struct VID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VID>(arg0, 9, b"VID", b"gjvi", b"hvj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/763abe77-0124-4694-a920-f21fc16ab426.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VID>>(v1);
    }

    // decompiled from Move bytecode v6
}

