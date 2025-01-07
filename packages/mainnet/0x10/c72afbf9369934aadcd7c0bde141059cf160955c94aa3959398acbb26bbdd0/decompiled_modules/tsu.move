module 0x10c72afbf9369934aadcd7c0bde141059cf160955c94aa3959398acbb26bbdd0::tsu {
    struct TSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSU>(arg0, 9, b"TSU", b"Tsunami", b"a big tsunami on SUI is comming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2e3bb9a-1da8-467d-8859-a2f675711f7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

