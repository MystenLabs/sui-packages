module 0x72d10e9318cd200c300ce49b2030036478218083c96c455ae9200273d5baa846::alf {
    struct ALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALF>(arg0, 9, b"ALF", b"Alirezaf", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5ac043d-a3aa-470f-a7b2-567e6ce9f70a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALF>>(v1);
    }

    // decompiled from Move bytecode v6
}

