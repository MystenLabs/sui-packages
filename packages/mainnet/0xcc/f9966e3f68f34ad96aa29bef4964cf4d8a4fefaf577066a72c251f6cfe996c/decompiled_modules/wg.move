module 0xccf9966e3f68f34ad96aa29bef4964cf4d8a4fefaf577066a72c251f6cfe996c::wg {
    struct WG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WG>(arg0, 9, b"WG", b"Wall Guha", b"Wall Guhaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8311ae84-a3f1-4b1f-b08d-7ae6fbe5840d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WG>>(v1);
    }

    // decompiled from Move bytecode v6
}

