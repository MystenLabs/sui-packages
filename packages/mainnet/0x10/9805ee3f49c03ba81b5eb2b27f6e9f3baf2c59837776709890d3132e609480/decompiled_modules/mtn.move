module 0x109805ee3f49c03ba81b5eb2b27f6e9f3baf2c59837776709890d3132e609480::mtn {
    struct MTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTN>(arg0, 9, b"MTN", b"Dragon", b"Prestigious double legendary wine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/addabe12-13fe-4ee3-8443-261ef26c1d49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

