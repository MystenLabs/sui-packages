module 0xf6488b9f7f2b696929bb621276f3d670f9eeace23ead8e178a91225b30fa4c6a::wls {
    struct WLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLS>(arg0, 9, b"WLS", b"Whales", b"Whales Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3936d22b-4a00-4deb-b073-095b04738979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

