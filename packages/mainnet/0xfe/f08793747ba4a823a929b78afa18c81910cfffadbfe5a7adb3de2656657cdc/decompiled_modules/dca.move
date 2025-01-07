module 0xfef08793747ba4a823a929b78afa18c81910cfffadbfe5a7adb3de2656657cdc::dca {
    struct DCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCA>(arg0, 9, b"DCA", b"Dan Cay", b"Dan Cay Airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e286268-a258-4cc7-987b-ad909eddd9ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

