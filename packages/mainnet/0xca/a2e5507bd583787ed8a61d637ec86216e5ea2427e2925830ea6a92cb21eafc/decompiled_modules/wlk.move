module 0xcaa2e5507bd583787ed8a61d637ec86216e5ea2427e2925830ea6a92cb21eafc::wlk {
    struct WLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLK>(arg0, 9, b"WLK", b"WALKERS", b"WALKERS ARE COMING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/573c3350-ee87-4a10-80cc-878391123cfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

