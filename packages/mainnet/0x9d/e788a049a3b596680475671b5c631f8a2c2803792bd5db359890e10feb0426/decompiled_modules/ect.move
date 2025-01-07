module 0x9de788a049a3b596680475671b5c631f8a2c2803792bd5db359890e10feb0426::ect {
    struct ECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECT>(arg0, 9, b"ECT", b"Elon Cat", b"Musk has a cat called Elon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/123143a5-a62e-4858-8225-2bdd071a56e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

