module 0x2f805f5063556b55a80e18ca4d5c5514820a9923592257219baa0506c77ada55::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT>(arg0, 9, b"HT", b"Doggs", b"Dogssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cae5645-9d5b-49a3-b54e-ad5c2589ce20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT>>(v1);
    }

    // decompiled from Move bytecode v6
}

